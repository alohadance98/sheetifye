class IndexMappingEngine {
  final int totalCount;

  // Mapping from visual index (what we see) to logical index (the actual data row)
  final List<int> _visualToLogical;

  // Mapping from logical index to visual index
  final Map<int, int> _logicalToVisual = {};

  IndexMappingEngine(this.totalCount, {List<int>? visualToLogical})
    : _visualToLogical =
          visualToLogical ?? List<int>.generate(totalCount, (i) => i) {
    _rebuildReverseMapping();
  }

  IndexMappingEngine copyWith(int newTotalCount) {
    // When expanding, we keep the existing mapping and add new indices at the end
    final newList = List<int>.from(_visualToLogical);
    if (newTotalCount > totalCount) {
      for (int i = totalCount; i < newTotalCount; i++) {
        newList.add(i);
      }
    }
    return IndexMappingEngine(newTotalCount, visualToLogical: newList);
  }

  int get visualCount => _visualToLogical.length;

  int getLogicalIndex(int visualIndex) {
    if (visualIndex < 0 || visualIndex >= _visualToLogical.length) return -1;
    return _visualToLogical[visualIndex];
  }

  int getVisualIndex(int logicalIndex) {
    return _logicalToVisual[logicalIndex] ?? -1;
  }

  void sortBy(int Function(int a, int b) comparator) {
    _visualToLogical.sort(comparator);
    _rebuildReverseMapping();
  }

  void filter(bool Function(int logicalIndex) predicate) {
    _visualToLogical.clear();
    for (int i = 0; i < totalCount; i++) {
      if (predicate(i)) {
        _visualToLogical.add(i);
      }
    }
    _rebuildReverseMapping();
  }

  void reset() {
    _visualToLogical.clear();
    for (int i = 0; i < totalCount; i++) {
      _visualToLogical.add(i);
    }
    _rebuildReverseMapping();
  }

  void _rebuildReverseMapping() {
    _logicalToVisual.clear();
    for (int i = 0; i < _visualToLogical.length; i++) {
      _logicalToVisual[_visualToLogical[i]] = i;
    }
  }
}

class VisibilityManager {
  final Set<int> hiddenRows = {};
  final Set<int> hiddenCols = {};

  void hideRow(int row) => hiddenRows.add(row);
  void showRow(int row) => hiddenRows.remove(row);

  void hideCol(int col) => hiddenCols.add(col);
  void showCol(int col) => hiddenCols.remove(col);

  bool isRowHidden(int row) => hiddenRows.contains(row);
  bool isColHidden(int col) => hiddenCols.contains(col);
}
