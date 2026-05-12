import 'package:xml/xml.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_archive_reader.dart';

class XlsxStylesParser {
  static XlsxStyleTable parse(XlsxArchiveReader reader) {
    final xml = reader.getXml('xl/styles.xml');
    if (xml == null) return XlsxStyleTable.empty();

    final fonts = _parseFonts(xml);
    final fills = _parseFills(xml);
    final cellXfs = _parseCellXfs(xml, fonts, fills);

    return XlsxStyleTable(cellXfs: cellXfs);
  }

  static List<XlsxFont> _parseFonts(XmlDocument xml) {
    return xml.findAllElements('font').map((e) {
      return XlsxFont(
        isBold: e.findElements('b').isNotEmpty,
        isItalic: e.findElements('i').isNotEmpty,
        fontSize:
            double.tryParse(e.getElement('sz')?.getAttribute('val') ?? '') ??
            11.0,
      );
    }).toList();
  }

  static List<XlsxFill> _parseFills(XmlDocument xml) {
    return xml.findAllElements('fill').map((e) {
      final fgColor = e.findAllElements('fgColor').firstOrNull;
      return XlsxFill(colorHex: fgColor?.getAttribute('rgb'));
    }).toList();
  }

  static List<XlsxCellStyle> _parseCellXfs(
    XmlDocument xml,
    List<XlsxFont> fonts,
    List<XlsxFill> fills,
  ) {
    final xfs = xml.getElement('styleSheet')?.getElement('cellXfs');
    if (xfs == null) return [];

    return xfs.findElements('xf').map((e) {
      final fontId = int.tryParse(e.getAttribute('fontId') ?? '');
      final fillId = int.tryParse(e.getAttribute('fillId') ?? '');
      return XlsxCellStyle(
        font: fontId != null && fontId < fonts.length ? fonts[fontId] : null,
        fill: fillId != null && fillId < fills.length ? fills[fillId] : null,
      );
    }).toList();
  }
}

class XlsxStyleTable {
  final List<XlsxCellStyle> cellXfs;
  XlsxStyleTable({required this.cellXfs});
  factory XlsxStyleTable.empty() => XlsxStyleTable(cellXfs: []);
}

class XlsxCellStyle {
  final XlsxFont? font;
  final XlsxFill? fill;
  XlsxCellStyle({this.font, this.fill});
}

class XlsxFont {
  final bool isBold;
  final bool isItalic;
  final double fontSize;
  XlsxFont({this.isBold = false, this.isItalic = false, this.fontSize = 11.0});
}

class XlsxFill {
  final String? colorHex;
  XlsxFill({this.colorHex});
}
