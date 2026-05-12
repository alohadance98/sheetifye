import 'package:xml/xml.dart';
import 'package:sheetifye/src/data/adapters/xlsx/xlsx_archive_reader.dart';

class XlsxSharedStringsParser {
  static List<String> parse(XlsxArchiveReader reader) {
    final xml = reader.getXml('xl/sharedStrings.xml');
    if (xml == null) return [];

    // Excel stores shared strings in <si><t>... or <si><r><t>...
    return xml.findAllElements('si').map((si) {
      final tElements = si.findAllElements('t');
      if (tElements.isEmpty) return '';
      // Concatenate all text parts (in case of rich text formatting)
      return tElements.map((e) => e.innerText).join('');
    }).toList();
  }
}
