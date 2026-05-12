class PerformanceHarness {
  final List<BenchmarkResult> _results = [];

  void runBenchmark(String name, void Function() task) {
    final stopwatch = Stopwatch()..start();
    task();
    stopwatch.stop();
    _results.add(BenchmarkResult(name, stopwatch.elapsedMicroseconds));
  }

  void report() {
    print('--- Sheetify Performance Report ---');
    for (final result in _results) {
      print('${result.name}: ${result.microseconds}µs');
    }
  }
}

class BenchmarkResult {
  final String name;
  final int microseconds;
  BenchmarkResult(this.name, this.microseconds);
}
