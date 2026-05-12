import 'package:sheetifye/src/data/persistence/workbook_serializer.dart';
import 'package:sheetifye/src/domain/entities/workbook.dart';

class SnapshotManager {
  final List<Map<String, dynamic>> _snapshots = [];
  final WorkbookSerializer _serializer = WorkbookSerializer();

  void takeSnapshot(Workbook workbook) {
    _snapshots.add(_serializer.serialize(workbook));
    if (_snapshots.length > 50) {
      _snapshots.removeAt(0); // Cap history
    }
  }

  Map<String, dynamic>? getLatestSnapshot() {
    return _snapshots.isEmpty ? null : _snapshots.last;
  }

  void clear() => _snapshots.clear();
}
