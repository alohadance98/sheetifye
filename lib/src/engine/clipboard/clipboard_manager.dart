import 'package:flutter/services.dart';
import 'package:sheetify/src/core/utils/grid_utils.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';

class ClipboardManager {
  Future<void> copyToClipboard(GridRange range, Sheet sheet) async {
    final buffer = StringBuffer();
    for (int r = range.minRow; r <= range.maxRow; r++) {
      final rowValues = [];
      for (int c = range.minCol; c <= range.maxCol; c++) {
        final cell = sheet.cells['$r,$c'];
        rowValues.add(cell?.value?.toString() ?? '');
      }
      buffer.writeln(rowValues.join('\t'));
    }
    await Clipboard.setData(ClipboardData(text: buffer.toString().trimRight()));
  }

  Future<Map<String, dynamic>?> getFromClipboard(GridCoordinate target, Sheet sheet) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text == null) return null;

    final Map<String, dynamic> mutations = {};
    final lines = data!.text!.split('\n');
    
    for (int i = 0; i < lines.length; i++) {
      final cells = lines[i].split('\t');
      final targetRow = target.row + i;
      if (targetRow >= sheet.rowCount) break;

      for (int j = 0; j < cells.length; j++) {
        final targetCol = target.column + j;
        if (targetCol >= sheet.columnCount) break;
        
        mutations['$targetRow,$targetCol'] = cells[j];
      }
    }
    return mutations;
  }
}
