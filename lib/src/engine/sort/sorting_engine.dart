import 'package:sheetifye/src/engine/sort/index_mapping_engine.dart';

enum SortOrder { ascending, descending }

class SortDescriptor {
  final int columnIndex;
  final SortOrder order;

  const SortDescriptor({
    required this.columnIndex,
    this.order = SortOrder.ascending,
  });
}

class SortingEngine {
  void sortSheet(
    IndexMappingEngine mapping,
    List<SortDescriptor> descriptors,
    dynamic Function(int row, int col) valueProvider,
  ) {
    mapping.sortBy((a, b) {
      for (final descriptor in descriptors) {
        final valA = valueProvider(a, descriptor.columnIndex);
        final valB = valueProvider(b, descriptor.columnIndex);

        final comparison = _compareValues(valA, valB);
        if (comparison != 0) {
          return descriptor.order == SortOrder.ascending
              ? comparison
              : -comparison;
        }
      }
      return a.compareTo(b); // Stable sort fallback to logical index
    });
  }

  int _compareValues(dynamic a, dynamic b) {
    if (a == b) return 0;
    if (a == null) return -1;
    if (b == null) return 1;

    if (a is num && b is num) return a.compareTo(b);
    return a.toString().compareTo(b.toString());
  }
}
