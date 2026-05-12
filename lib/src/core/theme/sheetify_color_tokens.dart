import 'package:flutter/material.dart';

/// Semantic color tokens for the Sheetify design system.
/// These represent the 'intent' of colors rather than their absolute values.
class SheetifyColorTokens {
  // Brand Colors
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFFBBDEFB);

  // Surface Colors
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  static const Color shadow = Color(0x1A000000); // Black 10%
  static const Color onSurface = Color(0xFF202124);
  static const Color onSurfaceVariant = Color(0xFF5F6368);

  // Grid Colors
  static const Color gridLine = Color(0xFFE0E0E0);
  static const Color gridLineDark = Color(0xFF3C4043);
  static const Color headerBackground = Color(0xFFF1F3F4);
  static const Color headerBackgroundDark = Color(0xFF202124);

  // Selection Colors
  static const Color selection = Color(0xFFE8F0FE);
  static const Color selectionBorder = Color(0xFF1A73E8);
  static const Color searchHighlight = Color(0xFFFFF176); // Yellow 300
  static const Color searchHighlightBorder = Color(0xFFFBC02D); // Yellow 700

  // Status Colors
  static const Color error = Color(0xFFD93025);
  static const Color warning = Color(0xFFF9AB00);
  static const Color success = Color(0xFF1E8E3E);
  static const Color info = Color(0xFF1A73E8);

  // Status Indicator Colors (Banners)
  static const Color statusBackground = Color(0xFFE8F0FE);
  static const Color statusForeground = Color(0xFF1967D2);
}
