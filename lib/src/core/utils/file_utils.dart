import 'dart:convert';

class FileUtils {
  static String workbookToJson(Map<String, dynamic> data) {
    return jsonEncode(data);
  }

  static Map<String, dynamic> jsonToWorkbook(String json) {
    return jsonDecode(json);
  }

  /// Converts a list of rows (list of strings) to a CSV string
  static String toCsv(List<List<String>> rows) {
    return rows.map((row) => row.join(',')).join('\n');
  }

  /// Parses a CSV string into a list of rows
  static List<List<String>> fromCsv(String csv) {
    return csv.split('\n').map((line) => line.split(',')).toList();
  }
}
