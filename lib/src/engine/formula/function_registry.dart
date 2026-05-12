class FunctionRegistry {
  final Map<String, dynamic Function(List<dynamic>)> _functions = {};

  FunctionRegistry() {
    _registerBuiltIns();
  }

  void register(String name, dynamic Function(List<dynamic>) executor) {
    _functions[name.toUpperCase()] = executor;
  }

  dynamic execute(String name, List<dynamic> args) {
    final func = _functions[name.toUpperCase()];
    if (func == null) return '#NAME?';
    return func(args);
  }

  void _registerBuiltIns() {
    register('SUM', (args) {
      double sum = 0;
      for (var arg in args) {
        if (arg is Iterable) {
          for (var v in arg) {
            if (v is num) sum += v;
          }
        } else if (arg is num) {
          sum += arg;
        }
      }
      return sum;
    });

    register('IF', (args) {
      if (args.length < 3) return '#VALUE!';
      final condition = args[0];
      final isTrue =
          (condition == true || (condition is num && condition != 0));
      return isTrue ? args[1] : args[2];
    });
  }
}
