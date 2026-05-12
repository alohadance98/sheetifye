import 'package:flutter/material.dart';
import 'package:sheetifye/src/core/theme/sheetifye_theme_data.dart';

class SheetifyeTheme extends StatelessWidget {
  final SheetifyeThemeData data;
  final Widget child;

  const SheetifyeTheme({super.key, required this.data, required this.child});

  static SheetifyeThemeData of(BuildContext context) {
    final theme = Theme.of(context).extension<SheetifyeThemeData>();
    return theme ?? SheetifyeThemeData.light();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
