import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized typography tokens for Sheetify.
class SheetifyTextTokens {
  // Base font family
  static String get fontFamily => GoogleFonts.inter().fontFamily ?? 'Inter';
  static String get monoFontFamily =>
      GoogleFonts.robotoMono().fontFamily ?? 'monospace';

  // Semantic Text Styles
  static TextStyle get toolbarTitle =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.2);

  static TextStyle get formulaBar =>
      TextStyle(fontSize: 13, fontFamily: monoFontFamily);

  static TextStyle get gridHeader =>
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  static TextStyle get gridCell =>
      TextStyle(fontSize: 13, fontWeight: FontWeight.normal);

  static TextStyle get tabActive =>
      TextStyle(fontSize: 13, fontWeight: FontWeight.w600);

  static TextStyle get tabInactive =>
      TextStyle(fontSize: 13, fontWeight: FontWeight.normal);

  static TextStyle get statusLabel =>
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.1);

  static TextStyle get statusBody => TextStyle(fontSize: 11);
}
