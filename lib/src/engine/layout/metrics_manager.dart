import 'dart:collection';

class MetricsManager {
  final double defaultSize;

  // Stores only the sizes that differ from defaultSize
  final SplayTreeMap<int, double> _overriddenSizes =
      SplayTreeMap<int, double>();

  // Cached cumulative diffs for fast offset calculation
  // [index, cumulative_diff]
  final List<MapEntry<int, double>> _cachedDiffs = [];
  bool _isCacheDirty = true;

  MetricsManager({required this.defaultSize});

  void setSize(int index, double size) {
    if (size == defaultSize) {
      if (_overriddenSizes.containsKey(index)) {
        _overriddenSizes.remove(index);
        _isCacheDirty = true;
      }
      return;
    }
    if (_overriddenSizes[index] == size) return;
    _overriddenSizes[index] = size;
    _isCacheDirty = true;
  }

  double getSize(int index) {
    return _overriddenSizes[index] ?? defaultSize;
  }

  void _updateCache() {
    if (!_isCacheDirty) return;

    _cachedDiffs.clear();
    double cumulativeDiff = 0;

    for (final entry in _overriddenSizes.entries) {
      cumulativeDiff += (entry.value - defaultSize);
      _cachedDiffs.add(MapEntry(entry.key, cumulativeDiff));
    }

    _isCacheDirty = false;
  }

  double getOffset(int index, int totalCount) {
    if (index <= 0) return 0;

    // Base offset if all were default size
    double offset = index * defaultSize;

    // Add cumulative differences from overrides before this index
    _updateCache();
    if (_cachedDiffs.isNotEmpty) {
      // Binary search for the last override index < index
      int low = 0;
      int high = _cachedDiffs.length - 1;
      int foundIndex = -1;

      while (low <= high) {
        int mid = (low + high) ~/ 2;
        if (_cachedDiffs[mid].key < index) {
          foundIndex = mid;
          low = mid + 1;
        } else {
          high = mid - 1;
        }
      }

      if (foundIndex != -1) {
        offset += _cachedDiffs[foundIndex].value;
      }
    }

    return offset;
  }

  int getIndex(double offset, int totalCount) {
    if (offset <= 0) return 0;

    // Initial estimate based on default size
    // Refine based on overrides.
    // Since cumulative diffs change the 'landscape', we need a more robust search.
    // O(log Overrides) approach:
    _updateCache();

    int low = 0;
    int high = totalCount - 1;
    int result = 0;

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      if (getOffset(mid, totalCount) <= offset) {
        result = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    return result;
  }

  double getTotalSize(int totalCount) {
    return getOffset(totalCount, totalCount);
  }

  void clearOverrides() {
    _overriddenSizes.clear();
    _isCacheDirty = true;
  }
}
