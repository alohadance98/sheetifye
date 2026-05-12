import 'package:sheetify/src/domain/entities/cell.dart';

class FormattingEngine {
  final Map<String, CellStyle> _styleCache = {};

  CellStyle getStyle(String? styleId) {
    return _styleCache[styleId] ?? const CellStyle();
  }

  void registerStyle(String id, CellStyle style) {
    _styleCache[id] = style;
  }
}

class ConditionalFormattingRule {
  final bool Function(dynamic value) predicate;
  final CellStyle style;

  ConditionalFormattingRule({required this.predicate, required this.style});
}

class ConditionalFormattingEngine {
  final Map<String, List<ConditionalFormattingRule>> _rules = {};

  void addRule(String rangeAddress, ConditionalFormattingRule rule) {
    _rules.putIfAbsent(rangeAddress, () => []).add(rule);
  }

  CellStyle? getAppliedStyle(int row, int col, dynamic value) {
    // Simplified: check rules for the cell
    // In production, we'd check if the cell is within any of the rule ranges
    return null;
  }
}
