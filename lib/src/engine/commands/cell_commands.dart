import 'package:sheetify/src/engine/commands/spreadsheet_command.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/domain/entities/cell.dart';

class UpdateCellCommand extends SpreadsheetCommand {
  final int row;
  final int col;
  final dynamic newValue;
  Cell? _oldCell;

  UpdateCellCommand({
    required this.row,
    required this.col,
    required this.newValue,
  });

  @override
  String get label => 'Update Cell';

  @override
  void execute(Workbook workbook) {
    final sheet = workbook.activeSheet;
    _oldCell = sheet.cells['$row,$col'];

    sheet.cells['$row,$col'] = Cell(
      id: '$row,$col',
      row: row,
      column: col,
      value: newValue is String && newValue.startsWith('=') ? null : newValue,
      rawInput: newValue.toString(),
    );
  }

  @override
  void undo(Workbook workbook) {
    final sheet = workbook.activeSheet;
    if (_oldCell != null) {
      sheet.cells['$row,$col'] = _oldCell!;
    }
  }
}

class UpdateRangeCommand extends SpreadsheetCommand {
  final Map<String, dynamic> newValues;
  final Map<String, Cell> _oldCells = {};

  UpdateRangeCommand(this.newValues);

  @override
  String get label => 'Update Range';

  @override
  void execute(Workbook workbook) {
    final sheet = workbook.activeSheet;
    newValues.forEach((key, value) {
      _oldCells[key] = sheet.cells[key]!;

      final parts = key.split(',');
      final row = int.parse(parts[0]);
      final col = int.parse(parts[1]);

      sheet.cells[key] = Cell(
        id: key,
        row: row,
        column: col,
        value: value is String && value.startsWith('=') ? null : value,
        rawInput: value.toString(),
      );
    });
  }

  @override
  void undo(Workbook workbook) {
    final sheet = workbook.activeSheet;
    _oldCells.forEach((key, cell) {
      sheet.cells[key] = cell;
    });
  }
}
