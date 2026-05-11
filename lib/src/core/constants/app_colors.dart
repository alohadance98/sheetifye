import 'package:flutter/material.dart';

/// All colours used in the app — never hardcode hex values anywhere else.
///
/// Light / dark variants are exposed so the theme can pick the right one.
abstract final class AppColors {
  // ── Brand / Primary ───────────────────────────────────────────────────────
  static const primary = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF1976D2);
  static const primaryDark = Color(0xFF0D47A1);
  static const onPrimary = Colors.white;

  // ── Surface ───────────────────────────────────────────────────────────────
  static const surface = Colors.white;
  static const surfaceVariant = Color(0xFFF5F5F5);
  static const surfaceHeader = Color(0xFFEEEEEE);

  // ── Dark mode surfaces ────────────────────────────────────────────────────
  static const surfaceDark = Color(0xFF1E1E1E);
  static const surfaceVariantDark = Color(0xFF2C2C2C);
  static const surfaceHeaderDark = Color(0xFF2A2A2A);

  // ── Grid lines ────────────────────────────────────────────────────────────
  static const gridLine = Color(0xFFE0E0E0);
  static const gridLineDark = Color(0xFF3A3A3A);

  // ── Cell selection ────────────────────────────────────────────────────────
  static const cellSelected = Color(0xFFE8F0FE);
  static const cellSelectedBorder = Color(0xFF1565C0);
  static const cellSelectedDark = Color(0xFF1A2E4A);

  // ── Cell type accent colours ──────────────────────────────────────────────
  static const cellDate = Color(0xFF6A1B9A);
  static const cellFormula = Color(0xFF1B5E20);
  static const cellError = Color(0xFFB71C1C);
  static const cellBool = Color(0xFF0277BD);

  // ── Status / semantic ─────────────────────────────────────────────────────
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFF57F17);
  static const error = Color(0xFFC62828);
  static const info = Color(0xFF0277BD);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textHint = Color(0xFFBDBDBD);

  // ── Tab bar ───────────────────────────────────────────────────────────────
  static const tabActive = primary;
  static const tabInactive = Color(0xFF9E9E9E);
  static const tabBar = Colors.white;
  static const tabBarDark = Color(0xFF252525);

  // ── Formula bar ───────────────────────────────────────────────────────────
  static const formulaBar = Color(0xFFE3F2FD);
  static const formulaBarDark = Color(0xFF1A2744);
  static const formulaBarBorder = Color(0xFF90CAF9);
  static const formulaText = Color(0xFF0D47A1);
}
