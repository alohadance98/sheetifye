import 'dart:async';
import 'package:flutter/foundation.dart';

class RenderScheduler {
  bool _isScheduled = false;
  final List<VoidCallback> _callbacks = [];

  void schedule(VoidCallback callback) {
    _callbacks.add(callback);
    if (!_isScheduled) {
      _isScheduled = true;
      scheduleMicrotask(() {
        for (final cb in _callbacks) {
          cb();
        }
        _callbacks.clear();
        _isScheduled = false;
      });
    }
  }
}

class RecalculationScheduler {
  Timer? _debounceTimer;

  void schedule(Duration delay, VoidCallback action) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, action);
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
