import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/sheetifye.dart';
import 'package:sheetifye/src/engine/formula/recalculation_engine.dart';
import 'package:sheetifye/src/engine/commands/command_manager.dart';
import 'package:sheetifye/src/engine/commands/cell_commands.dart';
import 'package:sheetifye/src/engine/clipboard/clipboard_manager.dart';
import 'package:sheetifye/src/engine/layout/layout_engine.dart';
import 'package:sheetifye/src/data/adapters/xlsx/xlsx_adapter.dart';
import 'dart:typed_data';

class WorkbookState {
  final Workbook workbook;
  final GridCoordinate? activeCell;
  final GridRange? mainSelection;
  final List<GridRange> additionalSelections;
  final bool isDragging;
  final bool isEditing;
  final bool readOnly;
  final String? searchQuery;
  final bool isSearchOpen;

  WorkbookState({
    required this.workbook,
    this.activeCell,
    this.mainSelection,
    this.additionalSelections = const [],
    this.isDragging = false,
    this.isEditing = false,
    this.readOnly = true,
    this.searchQuery,
    this.isSearchOpen = false,
  });

  WorkbookState copyWith({
    Workbook? workbook,
    GridCoordinate? activeCell,
    GridRange? mainSelection,
    List<GridRange>? additionalSelections,
    bool? isDragging,
    bool? isEditing,
    bool? readOnly,
    String? searchQuery,
    bool? isSearchOpen,
  }) {
    return WorkbookState(
      workbook: workbook ?? this.workbook,
      activeCell: activeCell ?? this.activeCell,
      mainSelection: mainSelection ?? this.mainSelection,
      additionalSelections: additionalSelections ?? this.additionalSelections,
      isDragging: isDragging ?? this.isDragging,
      isEditing: isEditing ?? this.isEditing,
      readOnly: readOnly ?? this.readOnly,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearchOpen: isSearchOpen ?? this.isSearchOpen,
    );
  }
}

class WorkbookController extends StateNotifier<WorkbookState> {
  final CommandManager _commandManager = CommandManager();
  final ClipboardManager _clipboardManager = ClipboardManager();
  final RecalculationEngine _recalculationEngine = RecalculationEngine();

  WorkbookController()
    : super(
        WorkbookState(
          workbook: Workbook(
            id: 'default-workbook',
            name: 'New Workbook',
            sheets: [Sheet(id: 'sheet-1', name: 'Sheet1')],
          ),
        ),
      );

  bool get canEdit => !state.readOnly;

  void setReadOnly(bool readOnly) {
    state = state.copyWith(readOnly: readOnly, isEditing: false);
  }

  void loadWorkbook(Workbook workbook) {
    state = state.copyWith(workbook: workbook, readOnly: false);

    // Initial recalculation for all formulas
    for (final entry in workbook.activeSheet.cells.entries) {
      if (entry.value.formula != null) {
        _recalculateCell(entry.key, entry.value.formula!);
      }
    }

    // Select the first cell by default
    selectCell(0, 0);
    _notifyState();
  }

  void loadFromXlsx(Uint8List bytes) {
    final workbook = XlsxAdapter.parse(bytes);
    loadWorkbook(workbook);
  }

  void switchSheet(int index) {
    final workbook = state.workbook.copyWith(activeSheetIndex: index);
    state = state.copyWith(workbook: workbook);

    // Recalculate all formulas in the new sheet
    for (final entry in workbook.activeSheet.cells.entries) {
      if (entry.value.formula != null) {
        _recalculateCell(entry.key, entry.value.formula!);
      }
    }
    _notifyState();
  }

  void addSheet() {
    if (!canEdit) return;
    final newSheet = Sheet(
      id: 'sheet-${state.workbook.sheets.length + 1}',
      name: 'Sheet${state.workbook.sheets.length + 1}',
    );
    final sheets = List<Sheet>.from(state.workbook.sheets)..add(newSheet);
    final workbook = state.workbook.copyWith(
      sheets: sheets,
      activeSheetIndex: sheets.length - 1,
    );
    state = state.copyWith(workbook: workbook);
    _notifyState();
  }

  void deleteSheet(int index) {
    if (!canEdit) return;
    final currentWorkbook = state.workbook;
    if (currentWorkbook.sheets.length <= 1) return;

    // Create a fresh list for immutability and notification
    final List<Sheet> newSheets = List<Sheet>.from(currentWorkbook.sheets);
    newSheets.removeAt(index);

    int newActiveIndex = currentWorkbook.activeSheetIndex;

    // Adjust active index if it's now out of bounds
    if (newActiveIndex >= newSheets.length) {
      newActiveIndex = newSheets.length - 1;
    }

    // Force state update with clean references
    final updatedWorkbook = currentWorkbook.copyWith(
      sheets: newSheets,
      activeSheetIndex: newActiveIndex,
    );

    state = state.copyWith(
      workbook: updatedWorkbook,
      activeCell: null,
      mainSelection: null,
      additionalSelections: [],
      isEditing: false,
    );

    _notifyState();
  }

  void renameSheet(int index, String newName) {
    if (!canEdit) return;
    final sheets = List<Sheet>.from(state.workbook.sheets);
    sheets[index] = sheets[index].copyWith(name: newName);
    final workbook = state.workbook.copyWith(sheets: sheets);
    state = state.copyWith(workbook: workbook);
    _notifyState();
  }

  void updateCellValue(int row, int col, dynamic value) {
    if (!canEdit) return;
    final command = UpdateCellCommand(row: row, col: col, newValue: value);
    _commandManager.execute(command, state.workbook);

    // Trigger recalculation
    _recalculateCell('$row,$col', value.toString());
    _notifyState();
  }

  void _recalculateCell(String address, String input) {
    _recalculationEngine.processCellUpdate(
      address,
      input,
      state.workbook.activeSheet,
      (addr, computedValue) {
        addr.split(',');
        final sheet = state.workbook.activeSheet;
        final existing = sheet.cells[addr];
        if (existing != null) {
          sheet.cells[addr] = existing.copyWith(value: computedValue);
        }
      },
    );
  }

  void undo() {
    if (!canEdit) return;
    _commandManager.undo(state.workbook);
    _notifyState();
  }

  void redo() {
    if (!canEdit) return;
    _commandManager.redo(state.workbook);
    _notifyState();
  }

  Future<void> cut() async {
    if (!canEdit) return;
    if (state.mainSelection != null) {
      await copy();
      clearRange(state.mainSelection!);
    }
  }

  void clearRange(GridRange range) {
    if (!canEdit) return;
    final Map<String, dynamic> clearValues = {};
    for (int r = range.minRow; r <= range.maxRow; r++) {
      for (int c = range.minCol; c <= range.maxCol; c++) {
        clearValues['$r,$c'] = null;
      }
    }
    final command = UpdateRangeCommand(clearValues);
    _commandManager.execute(command, state.workbook);
    _notifyState();
  }

  Future<void> copy() async {
    if (state.mainSelection != null) {
      await _clipboardManager.copyToClipboard(
        state.mainSelection!,
        state.workbook.activeSheet,
      );
    }
  }

  Future<void> paste() async {
    if (!canEdit) return;
    if (state.activeCell != null) {
      final mutations = await _clipboardManager.getFromClipboard(
        state.activeCell!,
        state.workbook.activeSheet,
      );
      if (mutations != null) {
        final command = UpdateRangeCommand(mutations);
        _commandManager.execute(command, state.workbook);

        // Recalculate all pasted cells
        mutations.forEach((addr, val) {
          _recalculateCell(addr, val.toString());
        });

        _notifyState();
      }
    }
  }

  void sortRange(GridRange range, int column, {bool ascending = true}) {
    final sheet = state.workbook.activeSheet;
    final List<Map<int, Cell>> rowsToSort = [];

    // Collect data
    for (int r = range.minRow; r <= range.maxRow; r++) {
      final Map<int, Cell> rowData = {};
      for (int c = range.minCol; c <= range.maxCol; c++) {
        final cell =
            sheet.cells['$r,$c'] ??
            Cell(id: '$r,$c', row: r, column: c, value: null);
        rowData[c] = cell;
      }
      rowsToSort.add(rowData);
    }

    // Sort
    rowsToSort.sort((a, b) {
      final valA = a[column]?.value;
      final valB = b[column]?.value;
      if (valA == null && valB == null) return 0;
      if (valA == null) return 1;
      if (valB == null) return -1;

      if (valA is Comparable && valB is Comparable) {
        final cmp = valA.compareTo(valB);
        return ascending ? cmp : -cmp;
      }
      return 0;
    });

    // Apply
    if (!canEdit) return;
    final Map<String, dynamic> newValues = {};
    for (int i = 0; i < rowsToSort.length; i++) {
      final targetRow = range.minRow + i;
      rowsToSort[i].forEach((col, cell) {
        newValues['$targetRow,$col'] = cell.value;
      });
    }

    final command = UpdateRangeCommand(newValues);
    _commandManager.execute(command, state.workbook);
    _notifyState();
  }

  void _notifyState() {
    state = state.copyWith(workbook: state.workbook);
  }

  void selectCell(int row, int col) {
    expandIfNeeded(row, col);
    final range = GridRange.fromRect(row, col, row, col);
    state = state.copyWith(
      activeCell: GridCoordinate(row, col),
      mainSelection: range,
      additionalSelections: [],
      isEditing: false,
    );
  }

  void expandIfNeeded(int row, int col) {
    if (!canEdit) return;
    final sheet = state.workbook.activeSheet;
    bool needsUpdate = false;
    int newRowCount = sheet.rowCount;
    int newColCount = sheet.columnCount;

    // Expand rows if near or beyond boundary
    if (row >= sheet.rowCount - 5) {
      newRowCount = row + 100;
      needsUpdate = true;
    }

    // Expand columns if near or beyond boundary
    if (col >= sheet.columnCount - 2) {
      newColCount = col + 10;
      needsUpdate = true;
    }

    if (needsUpdate) {
      final newSheet = sheet.copyWith(
        rowCount: newRowCount,
        columnCount: newColCount,
        rowIndexManager: sheet.rowIndexManager.copyWith(newRowCount),
      );
      final sheets = List<Sheet>.from(state.workbook.sheets);
      sheets[state.workbook.activeSheetIndex] = newSheet;

      state = state.copyWith(workbook: state.workbook.copyWith(sheets: sheets));
    }
  }

  void startDrag(int row, int col) {
    expandIfNeeded(row, col);
    final coord = GridCoordinate(row, col);
    state = state.copyWith(
      activeCell: coord,
      mainSelection: GridRange.fromRect(row, col, row, col),
      isDragging: true,
      additionalSelections: [],
    );
  }

  void updateDrag(int row, int col) {
    if (state.isDragging && state.activeCell != null) {
      expandIfNeeded(row, col);
      final newRange = GridRange(
        start: state.activeCell!,
        end: GridCoordinate(row, col),
      );
      state = state.copyWith(mainSelection: newRange);
    }
  }

  void endDrag() {
    state = state.copyWith(isDragging: false);
  }

  void setEditing(bool editing) {
    if (!canEdit && editing) return;
    state = state.copyWith(isEditing: editing);
  }

  void commitEdit(String value) {
    if (!canEdit) {
      state = state.copyWith(isEditing: false);
      return;
    }
    if (state.activeCell != null) {
      updateCellValue(state.activeCell!.row, state.activeCell!.column, value);
    }
    state = state.copyWith(isEditing: false);
  }

  void cancelEdit() {
    state = state.copyWith(isEditing: false);
  }

  void toggleSearch() {
    state = state.copyWith(isSearchOpen: !state.isSearchOpen);
    if (!state.isSearchOpen) {
      state = state.copyWith(searchQuery: null);
    }
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void moveActiveCell(int rowOffset, int colOffset) {
    if (state.isEditing) return;
    if (state.activeCell != null) {
      final newRow = (state.activeCell!.row + rowOffset).clamp(0, 2000000);
      final newCol = (state.activeCell!.column + colOffset).clamp(0, 16384);
      selectCell(newRow, newCol);
    }
  }
}

final workbookProvider =
    StateNotifierProvider<WorkbookController, WorkbookState>((ref) {
      return WorkbookController();
    });

final layoutProvider = Provider<LayoutEngine>((ref) {
  return LayoutEngine();
});

int min(int a, int b) => a < b ? a : b;
int max(int a, int b) => a > b ? a : b;
