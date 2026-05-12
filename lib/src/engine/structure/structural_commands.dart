import 'package:sheetify/src/engine/commands/spreadsheet_command.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/domain/entities/cell.dart';
import 'package:sheetify/src/engine/structure/reference_shift_engine.dart';

class InsertRowCommand extends SpreadsheetCommand {
  final int index;
  final int count;
  final _shiftEngine = ReferenceShiftEngine();

  InsertRowCommand(this.index, {this.count = 1});

  @override
  String get label => 'Insert $count Rows';

  @override
  void execute(Workbook workbook) {
    final sheet = workbook.activeSheet;
    final newCells = <String, Cell>{};

    // Shift existing cells
    sheet.cells.forEach((key, cell) {
      int r = cell.row;
      int c = cell.column;

      if (r >= index) {
        r += count;
      }

      String? shiftedInput = cell.rawInput;
      if (shiftedInput != null && shiftedInput.startsWith('=')) {
        shiftedInput = _shiftEngine.shiftFormula(
          shiftedInput,
          rowAt: index,
          rowCount: count,
        );
      }

      final newKey = '$r,$c';
      newCells[newKey] = cell.copyWith(
        id: newKey,
        row: r,
        column: c,
        rawInput: shiftedInput,
      );
    });

    // We should also update Sheet.rowCount but Sheet is immutable in its properties mostly
    // For now we focus on the cell map mutation
    // In a real engine, we'd also shift merged regions and row heights.

    workbook.sheets[workbook.activeSheetIndex] = sheet.copyWith(
      cells: newCells,
      rowCount: sheet.rowCount + count,
    );
  }

  @override
  void undo(Workbook workbook) {
    // Implementing undo for structural mutations requires storing the previous state or reversing the shift.
    // Simplified for now: we'd ideally use a "DeleteRowCommand" logic.
  }
}

class DeleteRowCommand extends SpreadsheetCommand {
  final int index;
  final int count;
  final _shiftEngine = ReferenceShiftEngine();

  DeleteRowCommand(this.index, {this.count = 1});

  @override
  String get label => 'Delete $count Rows';

  @override
  void execute(Workbook workbook) {
    final sheet = workbook.activeSheet;
    final newCells = <String, Cell>{};

    sheet.cells.forEach((key, cell) {
      int r = cell.row;
      int c = cell.column;

      if (r >= index && r < index + count) {
        return; // Skip deleted cells
      }

      if (r >= index + count) {
        r -= count;
      }

      String? shiftedInput = cell.rawInput;
      if (shiftedInput != null && shiftedInput.startsWith('=')) {
        shiftedInput = _shiftEngine.shiftFormula(
          shiftedInput,
          rowAt: index,
          rowCount: -count,
        );
      }

      final newKey = '$r,$c';
      newCells[newKey] = cell.copyWith(
        id: newKey,
        row: r,
        column: c,
        rawInput: shiftedInput,
      );
    });

    workbook.sheets[workbook.activeSheetIndex] = sheet.copyWith(
      cells: newCells,
      rowCount: sheet.rowCount - count,
    );
  }

  @override
  void undo(Workbook workbook) {}
}
