import 'package:xml/xml.dart';
import 'package:sheetify/src/core/utils/grid_utils.dart';
import 'package:sheetify/sheetify.dart' as entities;
import 'package:sheetify/src/engine/merge/merged_cell_manager.dart';

class XlsxSheetParser {
  static XlsxSheetData parse(XmlDocument xml, List<String> sharedStrings) {
    final Map<String, entities.Cell> cells = {};
    int maxR = 0;
    int maxC = 0;

    // 1. Dimensions
    final dimension = xml.findAllElements('dimension').firstOrNull;
    if (dimension != null) {
      final ref = dimension.getAttribute('ref');
      if (ref != null && ref.contains(':')) {
        final end = GridUtils.parseAddress(ref.split(':')[1]);
        maxR = end.row + 1;
        maxC = end.column + 1;
      }
    }

    // 2. Cell Data
    for (final rowElement in xml.findAllElements('row')) {
      final rowIndex = int.parse(rowElement.getAttribute('r') ?? '1') - 1;
      if (rowIndex >= maxR) maxR = rowIndex + 1;

      for (final cElement in rowElement.findElements('c')) {
        final addressA1 = cElement.getAttribute('r');
        if (addressA1 == null) continue;

        final coord = GridUtils.parseAddress(addressA1);
        if (coord.column >= maxC) maxC = coord.column + 1;

        final type = cElement.getAttribute('t');
        final vElem = cElement.getElement('v');
        final fElem = cElement.getElement('f');

        dynamic value;
        if (vElem != null) {
          final raw = vElem.innerText;
          if (type == 's') {
            final idx = int.tryParse(raw);
            if (idx != null && idx < sharedStrings.length)
              value = sharedStrings[idx];
          } else if (type == 'b') {
            value = raw == '1';
          } else {
            value = double.tryParse(raw) ?? raw;
          }
        }

        final addr = '${coord.row},${coord.column}';
        cells[addr] = entities.Cell(
          id: addr,
          row: coord.row,
          column: coord.column,
          value: value,
          formula: fElem?.innerText,
        );
      }
    }

    // 3. Merged Cells
    final mergeManager = MergedCellManager();
    for (final merge in xml.findAllElements('mergeCell')) {
      final ref = merge.getAttribute('ref');
      if (ref != null && ref.contains(':')) {
        final parts = ref.split(':');
        final start = GridUtils.parseAddress(parts[0]);
        final end = GridUtils.parseAddress(parts[1]);
        mergeManager.addRegion(
          GridRange.fromRect(start.row, start.column, end.row, end.column),
        );
      }
    }

    return XlsxSheetData(
      cells: cells,
      rowCount: maxR,
      columnCount: maxC,
      mergeManager: mergeManager,
    );
  }
}

class XlsxSheetData {
  final Map<String, entities.Cell> cells;
  final int rowCount;
  final int columnCount;
  final MergedCellManager mergeManager;

  XlsxSheetData({
    required this.cells,
    required this.rowCount,
    required this.columnCount,
    required this.mergeManager,
  });
}
