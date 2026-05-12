import 'dart:typed_data';
import 'package:sheetify/sheetify.dart' as entities;
import 'package:sheetify/src/engine/sort/index_mapping_engine.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_archive_reader.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_shared_strings_parser.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_workbook_parser.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_sheet_parser.dart';

class XlsxAdapter {
  /// Orchestrates the parsing of an XLSX file into a Sheetify Workbook.
  static entities.Workbook parse(
    Uint8List bytes, {
    String name = 'Imported Workbook',
  }) {
    final reader = XlsxArchiveReader(bytes);

    // 1. Shared Strings Table
    final sharedStrings = XlsxSharedStringsParser.parse(reader);

    // 2. Workbook Structure & Sheets
    final sheetMetas = XlsxWorkbookParser.parse(reader);

    final List<entities.Sheet> sheets = [];

    for (final meta in sheetMetas) {
      final sheetXml = reader.getXml(meta.path);
      if (sheetXml == null) continue;

      final sheetData = XlsxSheetParser.parse(sheetXml, sharedStrings);

      sheets.add(
        entities.Sheet(
          id: meta.name,
          name: meta.name,
          cells: sheetData.cells,
          rowCount: max(sheetData.rowCount, 100),
          columnCount: max(sheetData.columnCount, 26),
          mergedCells: sheetData.mergeManager,
          rowIndexManager: IndexMappingEngine(max(sheetData.rowCount, 100)),
        ),
      );
    }

    return entities.Workbook(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      sheets: sheets.isNotEmpty
          ? sheets
          : [entities.Sheet(id: '1', name: 'Sheet1')],
      activeSheetIndex: 0,
    );
  }

  static int max(int a, int b) => a > b ? a : b;
}
