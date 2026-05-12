import 'dart:collection';
import 'package:sheetifye/src/engine/commands/spreadsheet_command.dart';
import 'package:sheetifye/src/domain/entities/workbook.dart';

class CommandManager {
  final ListQueue<SpreadsheetCommand> _undoStack = ListQueue();
  final ListQueue<SpreadsheetCommand> _redoStack = ListQueue();
  final int maxHistory;

  CommandTransaction? _currentTransaction;

  CommandManager({this.maxHistory = 100});

  void beginTransaction(String label) {
    _currentTransaction = CommandTransaction(label);
  }

  void commitTransaction(Workbook workbook) {
    if (_currentTransaction != null &&
        _currentTransaction!.commands.isNotEmpty) {
      _executeAndAdd(_currentTransaction!, workbook);
    }
    _currentTransaction = null;
  }

  void rollbackTransaction() {
    _currentTransaction = null;
  }

  void execute(SpreadsheetCommand command, Workbook workbook) {
    if (_currentTransaction != null) {
      _currentTransaction!.add(command);
      command.execute(workbook);
    } else {
      _executeAndAdd(command, workbook);
    }
  }

  void _executeAndAdd(SpreadsheetCommand command, Workbook workbook) {
    command.execute(workbook);
    _undoStack.addLast(command);
    _redoStack.clear();
    if (_undoStack.length > maxHistory) {
      _undoStack.removeFirst();
    }
  }

  void undo(Workbook workbook) {
    if (_undoStack.isEmpty) return;
    final command = _undoStack.removeLast();
    command.undo(workbook);
    _redoStack.addLast(command);
  }

  void redo(Workbook workbook) {
    if (_redoStack.isEmpty) return;
    final command = _redoStack.removeLast();
    command.redo(workbook);
    _undoStack.addLast(command);
  }

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;
}
