import 'package:xml/xml.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_archive_reader.dart';

class XlsxWorkbookParser {
  static List<XlsxSheetMetadata> parse(XlsxArchiveReader reader) {
    final workbookXml = reader.getXml('xl/workbook.xml');
    final relsXml = reader.getXml('xl/_rels/workbook.xml.rels');
    if (workbookXml == null || relsXml == null) return [];

    // Map rId to Target (file path)
    final Map<String, String> rels = {};
    for (final rel in relsXml.findAllElements('Relationship')) {
      final id = rel.getAttribute('Id');
      final target = rel.getAttribute('Target');
      if (id != null && target != null) {
        rels[id] = target;
      }
    }

    final List<XlsxSheetMetadata> sheets = [];
    for (final sheet in workbookXml.findAllElements('sheet')) {
      final name = sheet.getAttribute('name');
      final rId = sheet.getAttribute('r:id');
      if (name != null && rId != null && rels.containsKey(rId)) {
        sheets.add(XlsxSheetMetadata(
          name: name,
          path: 'xl/${rels[rId]}',
        ));
      }
    }
    return sheets;
  }
}

class XlsxSheetMetadata {
  final String name;
  final String path;
  XlsxSheetMetadata({required this.name, required this.path});
}
