import 'package:sheetify/src/engine/sort/index_mapping_engine.dart';

abstract class FilterCriterion {
  bool matches(dynamic value);
}

class TextFilterCriterion extends FilterCriterion {
  final String pattern;
  final bool matchCase;

  TextFilterCriterion(this.pattern, {this.matchCase = false});

  @override
  bool matches(dynamic value) {
    if (value == null) return false;
    final valStr = value.toString();
    if (matchCase) {
      return valStr.contains(pattern);
    }
    return valStr.toLowerCase().contains(pattern.toLowerCase());
  }
}

class NumericFilterCriterion extends FilterCriterion {
  final double? min;
  final double? max;

  NumericFilterCriterion({this.min, this.max});

  @override
  bool matches(dynamic value) {
    if (value is! num) return false;
    if (min != null && value < min!) return false;
    if (max != null && value > max!) return false;
    return true;
  }
}

class FilteringEngine {
  void filterSheet(
    IndexMappingEngine mapping,
    Map<int, FilterCriterion> columnFilters,
    dynamic Function(int row, int col) valueProvider,
  ) {
    mapping.filter((logicalIndex) {
      for (final entry in columnFilters.entries) {
        final col = entry.key;
        final criterion = entry.value;
        final value = valueProvider(logicalIndex, col);

        if (!criterion.matches(value)) return false;
      }
      return true;
    });
  }
}
