import 'package:flutter/material.dart';

/// Standardized spacing tokens for Sheetify.
class SheetifySpacingTokens {
  static const double zero = 0.0;
  static const double xSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double xLarge = 24.0;
  static const double xxLarge = 32.0;

  // Semantic Spacing
  static const EdgeInsets toolbarPadding = EdgeInsets.symmetric(
    horizontal: medium,
  );
  static const EdgeInsets formulaBarPadding = EdgeInsets.symmetric(
    horizontal: medium,
    vertical: xSmall,
  );
  static const EdgeInsets tabPadding = EdgeInsets.symmetric(horizontal: large);
  static const EdgeInsets cardPadding = EdgeInsets.all(medium);
  static const EdgeInsets statusPadding = EdgeInsets.symmetric(
    vertical: xSmall,
    horizontal: large,
  );

  // Gaps
  static const double iconGap = small;
  static const double elementGap = medium;
}
