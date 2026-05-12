import 'dart:developer';

class PerformanceMonitor {
  static final Map<String, Stopwatch> _activeTimers = {};

  static void start(String label) {
    _activeTimers[label] = Stopwatch()..start();
  }

  static void stop(String label) {
    final stopwatch = _activeTimers.remove(label);
    if (stopwatch != null) {
      stopwatch.stop();
      final ms = stopwatch.elapsedMilliseconds;
      log('[Sheetifye Performance] $label: ${ms}ms');
    }
  }

  static T profile<T>(String label, T Function() computation) {
    start(label);
    try {
      return computation();
    } finally {
      stop(label);
    }
  }
}

class FrameProfiler {
  int _frameCount = 0;
  double _totalFrameTime = 0;

  void recordFrame(double durationMs) {
    _frameCount++;
    _totalFrameTime += durationMs;
  }

  double get averageFrameTime =>
      _frameCount == 0 ? 0 : _totalFrameTime / _frameCount;
}
