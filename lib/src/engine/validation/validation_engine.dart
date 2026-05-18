enum ValidationType { list, number, date, text, formula }

class ValidationRule {
  final ValidationType type;
  final dynamic criteria;
  final String errorMessage;
  final bool allowEmpty;

  ValidationRule({
    required this.type,
    required this.criteria,
    this.errorMessage = 'Invalid value',
    this.allowEmpty = true,
  });

  bool validate(dynamic value) {
    if (value == null || value.toString().isEmpty) return allowEmpty;

    switch (type) {
      case ValidationType.number:
        if (value is! num) return false;
        // Check criteria (min/max)
        return true;
      case ValidationType.list:
        if (criteria is List) {
          return criteria.contains(value.toString());
        }
        return false;
      default:
        return true;
    }
  }
}

class ValidationEngine {
  final Map<String, ValidationRule> _rules = {};

  void setValidation(int row, int col, ValidationRule rule) {
    _rules['$row,$col'] = rule;
  }

  bool isValid(int row, int col, dynamic value) {
    final rule = _rules['$row,$col'];
    if (rule == null) return true;
    return rule.validate(value);
  }

  ValidationRule? getRule(int row, int col) => _rules['$row,$col'];
}
