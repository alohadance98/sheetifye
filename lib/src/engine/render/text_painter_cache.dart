import 'package:flutter/material.dart';

class TextPainterCache {
  final Map<String, TextPainter> _cache = {};
  static const int _maxCacheSize = 1000;

  TextPainter getOrCreate({
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    final key = '$text-${style.hashCode}-$maxWidth';
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }

    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 1,
      ellipsis: '...',
    );
    painter.layout(maxWidth: maxWidth);

    if (_cache.length >= _maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = painter;
    return painter;
  }

  void clear() {
    _cache.clear();
  }
}
