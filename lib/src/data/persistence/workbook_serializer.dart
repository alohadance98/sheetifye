import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/domain/entities/cell.dart';

class WorkbookSerializer {
  Map<String, dynamic> serialize(Workbook workbook) {
    return {
      'version': '1.0',
      'id': workbook.id,
      'name': workbook.name,
      'activeSheetIndex': workbook.activeSheetIndex,
      'sheets': workbook.sheets.map((s) => _serializeSheet(s)).toList(),
    };
  }

  Map<String, dynamic> _serializeSheet(Sheet sheet) {
    return {
      'id': sheet.id,
      'name': sheet.name,
      'rowCount': sheet.rowCount,
      'columnCount': sheet.columnCount,
      'frozenRows': sheet.frozenRows,
      'frozenColumns': sheet.frozenColumns,
      'cells': sheet.cells.map((k, v) => MapEntry(k, _serializeCell(v))),
      'mergedRegions': sheet.mergedCells.regions
          .map(
            (r) => {
              'startRow': r.range.minRow,
              'endRow': r.range.maxRow,
              'startCol': r.range.minCol,
              'endCol': r.range.maxCol,
            },
          )
          .toList(),
    };
  }

  Map<String, dynamic> _serializeCell(Cell cell) {
    return {
      'id': cell.id,
      'row': cell.row,
      'column': cell.column,
      'value': cell.value,
      'rawInput': cell.rawInput,
      'formula': cell.formula,
      // Style would be serialized as a styleId or inline map
    };
  }
}
