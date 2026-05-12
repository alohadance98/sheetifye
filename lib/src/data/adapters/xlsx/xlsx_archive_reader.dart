import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

class XlsxArchiveReader {
  final Archive _archive;
  final Map<String, XmlDocument> _xmlCache = {};

  XlsxArchiveReader(Uint8List bytes) : _archive = ZipDecoder().decodeBytes(bytes);

  XmlDocument? getXml(String path) {
    if (_xmlCache.containsKey(path)) return _xmlCache[path];

    final file = _archive.findFile(path);
    if (file == null) return null;

    try {
      final xml = XmlDocument.parse(String.fromCharCodes(file.content));
      _xmlCache[path] = xml;
      return xml;
    } catch (e) {
      return null;
    }
  }

  List<String> getSheetPaths() {
    // Basic detection of worksheet files in xl/worksheets/
    return _archive.files
        .where((f) => f.name.startsWith('xl/worksheets/') && f.name.endsWith('.xml'))
        .map((f) => f.name)
        .toList();
  }

  bool hasFile(String path) => _archive.findFile(path) != null;
}
