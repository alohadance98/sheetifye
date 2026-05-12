import 'package:flutter/material.dart';
import 'package:sheetify/src/core/theme/sheetify_theme_data.dart';

class SheetifyTheme extends StatelessWidget {
  final SheetifyThemeData data;
  final Widget child;

  const SheetifyTheme({super.key, required this.data, required this.child});

  static SheetifyThemeData of(BuildContext context) {
    final theme = Theme.of(context).extension<SheetifyThemeData>();
    return theme ?? SheetifyThemeData.light();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
