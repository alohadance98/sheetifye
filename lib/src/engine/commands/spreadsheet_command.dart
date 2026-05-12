import 'package:sheetifye/src/domain/entities/workbook.dart';

abstract class SpreadsheetCommand {
  String get label;
  void execute(Workbook workbook);
  void undo(Workbook workbook);
  void redo(Workbook workbook) => execute(workbook);
}

class CommandTransaction extends SpreadsheetCommand {
  @override
  final String label;
  final List<SpreadsheetCommand> commands = [];

  CommandTransaction(this.label);

  void add(SpreadsheetCommand command) {
    commands.add(command);
  }

  @override
  void execute(Workbook workbook) {
    for (final command in commands) {
      command.execute(workbook);
    }
  }

  @override
  void undo(Workbook workbook) {
    for (final command in commands.reversed) {
      command.undo(workbook);
    }
  }
}
