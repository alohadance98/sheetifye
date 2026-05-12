import 'package:sheetifye/src/core/utils/grid_utils.dart';

class MergedRegion {
  final GridRange range;

  const MergedRegion(this.range);

  bool contains(int row, int col) => range.contains(row, col);

  bool isTopLeft(int row, int col) =>
      range.minRow == row && range.minCol == col;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MergedRegion &&
          runtimeType == other.runtimeType &&
          range == other.range;

  @override
  int get hashCode => range.hashCode;
}

class MergedCellManager {
  final List<MergedRegion> _regions = [];

  List<MergedRegion> get regions => List.unmodifiable(_regions);

  void addRegion(GridRange range) {
    // Check for overlaps (simplified for now)
    _regions.add(MergedRegion(range));
  }

  void removeRegion(GridRange range) {
    _regions.removeWhere((r) => r.range == range);
  }

  MergedRegion? getRegionFor(int row, int col) {
    for (final region in _regions) {
      if (region.contains(row, col)) return region;
    }
    return null;
  }

  bool isMerged(int row, int col) => getRegionFor(row, col) != null;

  bool isHidden(int row, int col) {
    final region = getRegionFor(row, col);
    if (region == null) return false;
    return !region.isTopLeft(row, col);
  }
}
