import 'package:flutter/material.dart';
import 'package:sheetify/src/core/theme/sheetify_color_tokens.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';
import 'package:sheetify/src/core/theme/sheetify_text_tokens.dart';

/// Defines the visual theme for [Sheetify] components.
///
/// [SheetifyThemeData] allows you to customize colors, typography, and
/// dimensions of the spreadsheet grid, headers, selection, and other UI elements.
///
/// It can be passed to the `theme` parameter of the [Sheetify] widget.
@immutable
class SheetifyThemeData extends ThemeExtension<SheetifyThemeData> {
  // Colors

  /// The primary color used for selection borders and focus indicators.
  final Color primaryColor;

  /// The background color of the entire spreadsheet area.
  final Color backgroundColor;

  /// The surface color for cells.
  final Color surfaceColor;

  /// The color of the lines between cells.
  final Color gridLineColor;

  /// The shadow color for floating elements.
  final Color shadowColor;

  /// The background color of the row and column headers.
  final Color headerBackgroundColor;

  /// The text color of the row and column headers.
  final Color headerForegroundColor;

  /// The fill color for selected cell ranges.
  final Color selectionColor;

  /// The border color for the active selection.
  final Color selectionBorderColor;

  /// The highlight color for search results.
  final Color searchHighlightColor;

  /// The border color for search highlights.
  final Color searchHighlightBorderColor;

  /// The background color of the formula bar.
  final Color formulaBarBackgroundColor;

  /// The text color of the formula bar.
  final Color formulaBarForegroundColor;

  /// The default text color for grid cells.
  final Color cellTextColor;

  /// The background color of status indicators (e.g., error/warning messages).
  final Color statusIndicatorBackgroundColor;

  /// The text color of status indicators.
  final Color statusIndicatorForegroundColor;

  // Status Colors

  /// Color for error states.
  final Color error;

  /// Color for warning states.
  final Color warning;

  /// Color for success states.
  final Color success;

  // Typography

  /// Style for text in the toolbar.
  final TextStyle toolbarTextStyle;

  /// Style for text in the formula bar.
  final TextStyle formulaBarTextStyle;

  /// Style for text in the row and column headers.
  final TextStyle gridHeaderTextStyle;

  /// Style for text in the grid cells.
  final TextStyle gridCellTextStyle;

  /// Style for text in the active sheet tab.
  final TextStyle tabActiveTextStyle;

  /// Style for text in inactive sheet tabs.
  final TextStyle tabInactiveTextStyle;

  /// Style for labels in status indicators.
  final TextStyle statusLabelTextStyle;

  /// Style for body text in status indicators.
  final TextStyle statusBodyTextStyle;

  // Dimensions

  /// The height of each row in the grid.
  final double rowHeight;

  /// The height of the column headers.
  final double columnHeaderHeight;

  /// The width of the row headers.
  final double rowHeaderWidth;

  /// The height of the top toolbar.
  final double toolbarHeight;

  /// The height of the formula bar.
  final double formulaBarHeight;

  /// The height of the sheet tab area at the bottom.
  final double tabAreaHeight;

  /// Creates a [SheetifyThemeData] with explicit values for all properties.
  const SheetifyThemeData({
    required this.primaryColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.gridLineColor,
    required this.shadowColor,
    required this.headerBackgroundColor,
    required this.headerForegroundColor,
    required this.selectionColor,
    required this.selectionBorderColor,
    required this.searchHighlightColor,
    required this.searchHighlightBorderColor,
    required this.formulaBarBackgroundColor,
    required this.formulaBarForegroundColor,
    required this.cellTextColor,
    required this.statusIndicatorBackgroundColor,
    required this.statusIndicatorForegroundColor,
    required this.error,
    required this.warning,
    required this.success,
    required this.toolbarTextStyle,
    required this.formulaBarTextStyle,
    required this.gridHeaderTextStyle,
    required this.gridCellTextStyle,
    required this.tabActiveTextStyle,
    required this.tabInactiveTextStyle,
    required this.statusLabelTextStyle,
    required this.statusBodyTextStyle,
    this.rowHeight = SheetifyDimensions.defaultRowHeight,
    this.columnHeaderHeight = SheetifyDimensions.headerHeight,
    this.rowHeaderWidth = SheetifyDimensions.headerWidth,
    this.toolbarHeight = SheetifyDimensions.toolbarHeight,
    this.formulaBarHeight = SheetifyDimensions.formulaBarHeight,
    this.tabAreaHeight = SheetifyDimensions.tabAreaHeight,
  });

  /// Creates a default light theme for Sheetify.
  factory SheetifyThemeData.light() {
    return SheetifyThemeData(
      primaryColor: SheetifyColorTokens.primary,
      backgroundColor: SheetifyColorTokens.surfaceVariant,
      surfaceColor: SheetifyColorTokens.surface,
      gridLineColor: SheetifyColorTokens.gridLine,
      shadowColor: SheetifyColorTokens.shadow,
      headerBackgroundColor: SheetifyColorTokens.headerBackground,
      headerForegroundColor: SheetifyColorTokens.onSurfaceVariant,
      selectionColor: SheetifyColorTokens.selection,
      selectionBorderColor: SheetifyColorTokens.selectionBorder,
      searchHighlightColor: SheetifyColorTokens.searchHighlight,
      searchHighlightBorderColor: SheetifyColorTokens.searchHighlightBorder,
      formulaBarBackgroundColor: SheetifyColorTokens.primaryLight.withValues(
        alpha: 0.3,
      ),
      formulaBarForegroundColor: SheetifyColorTokens.primaryDark,
      cellTextColor: SheetifyColorTokens.onSurface,
      statusIndicatorBackgroundColor: SheetifyColorTokens.statusBackground,
      statusIndicatorForegroundColor: SheetifyColorTokens.statusForeground,
      error: SheetifyColorTokens.error,
      warning: SheetifyColorTokens.warning,
      success: SheetifyColorTokens.success,

      toolbarTextStyle: SheetifyTextTokens.toolbarTitle.copyWith(
        color: Colors.white,
      ),
      formulaBarTextStyle: SheetifyTextTokens.formulaBar.copyWith(
        color: SheetifyColorTokens.primaryDark,
      ),
      gridHeaderTextStyle: SheetifyTextTokens.gridHeader.copyWith(
        color: SheetifyColorTokens.onSurfaceVariant,
      ),
      gridCellTextStyle: SheetifyTextTokens.gridCell.copyWith(
        color: SheetifyColorTokens.onSurface,
      ),
      tabActiveTextStyle: SheetifyTextTokens.tabActive.copyWith(
        color: SheetifyColorTokens.primary,
      ),
      tabInactiveTextStyle: SheetifyTextTokens.tabInactive.copyWith(
        color: SheetifyColorTokens.onSurfaceVariant,
      ),
      statusLabelTextStyle: SheetifyTextTokens.statusLabel.copyWith(
        color: SheetifyColorTokens.statusForeground,
      ),
      statusBodyTextStyle: SheetifyTextTokens.statusBody.copyWith(
        color: SheetifyColorTokens.statusForeground,
      ),
    );
  }

  /// Creates a default dark theme for Sheetify.
  factory SheetifyThemeData.dark() {
    return SheetifyThemeData(
      primaryColor: SheetifyColorTokens.primaryLight,
      backgroundColor: Colors.black,
      surfaceColor: const Color(0xFF1E1E1E),
      gridLineColor: SheetifyColorTokens.gridLineDark,
      shadowColor: Colors.black54,
      headerBackgroundColor: SheetifyColorTokens.headerBackgroundDark,
      headerForegroundColor: Colors.white70,
      selectionColor: SheetifyColorTokens.primary.withValues(alpha: 0.2),
      selectionBorderColor: SheetifyColorTokens.primaryLight,
      searchHighlightColor: SheetifyColorTokens.searchHighlight.withValues(
        alpha: 0.4,
      ),
      searchHighlightBorderColor: SheetifyColorTokens.searchHighlightBorder,
      formulaBarBackgroundColor: const Color(0xFF2C2C2C),
      formulaBarForegroundColor: Colors.white,
      cellTextColor: Colors.white,
      statusIndicatorBackgroundColor: const Color(0xFF332B00),
      statusIndicatorForegroundColor: const Color(0xFFFFD54F),
      error: const Color(0xFFE57373),
      warning: const Color(0xFFFFB74D),
      success: const Color(0xFF81C784),

      toolbarTextStyle: SheetifyTextTokens.toolbarTitle.copyWith(
        color: Colors.white,
      ),
      formulaBarTextStyle: SheetifyTextTokens.formulaBar.copyWith(
        color: Colors.white,
      ),
      gridHeaderTextStyle: SheetifyTextTokens.gridHeader.copyWith(
        color: Colors.white70,
      ),
      gridCellTextStyle: SheetifyTextTokens.gridCell.copyWith(
        color: Colors.white,
      ),
      tabActiveTextStyle: SheetifyTextTokens.tabActive.copyWith(
        color: SheetifyColorTokens.primaryLight,
      ),
      tabInactiveTextStyle: SheetifyTextTokens.tabInactive.copyWith(
        color: Colors.white70,
      ),
      statusLabelTextStyle: SheetifyTextTokens.statusLabel.copyWith(
        color: const Color(0xFFFFD54F),
      ),
      statusBodyTextStyle: SheetifyTextTokens.statusBody.copyWith(
        color: const Color(0xFFFFD54F),
      ),
    );
  }

  @override
  SheetifyThemeData copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? gridLineColor,
    Color? shadowColor,
    Color? headerBackgroundColor,
    Color? headerForegroundColor,
    Color? selectionColor,
    Color? selectionBorderColor,
    Color? searchHighlightColor,
    Color? searchHighlightBorderColor,
    Color? formulaBarBackgroundColor,
    Color? formulaBarForegroundColor,
    Color? cellTextColor,
    Color? statusIndicatorBackgroundColor,
    Color? statusIndicatorForegroundColor,
    Color? error,
    Color? warning,
    Color? success,
    TextStyle? toolbarTextStyle,
    TextStyle? formulaBarTextStyle,
    TextStyle? gridHeaderTextStyle,
    TextStyle? gridCellTextStyle,
    TextStyle? tabActiveTextStyle,
    TextStyle? tabInactiveTextStyle,
    TextStyle? statusLabelTextStyle,
    TextStyle? statusBodyTextStyle,
    double? rowHeight,
    double? columnHeaderHeight,
    double? rowHeaderWidth,
    double? toolbarHeight,
    double? formulaBarHeight,
    double? tabAreaHeight,
  }) {
    return SheetifyThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      gridLineColor: gridLineColor ?? this.gridLineColor,
      shadowColor: shadowColor ?? this.shadowColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerForegroundColor:
          headerForegroundColor ?? this.headerForegroundColor,
      selectionColor: selectionColor ?? this.selectionColor,
      selectionBorderColor: selectionBorderColor ?? this.selectionBorderColor,
      searchHighlightColor: searchHighlightColor ?? this.searchHighlightColor,
      searchHighlightBorderColor:
          searchHighlightBorderColor ?? this.searchHighlightBorderColor,
      formulaBarBackgroundColor:
          formulaBarBackgroundColor ?? this.formulaBarBackgroundColor,
      formulaBarForegroundColor:
          formulaBarForegroundColor ?? this.formulaBarForegroundColor,
      cellTextColor: cellTextColor ?? this.cellTextColor,
      statusIndicatorBackgroundColor:
          statusIndicatorBackgroundColor ?? this.statusIndicatorBackgroundColor,
      statusIndicatorForegroundColor:
          statusIndicatorForegroundColor ?? this.statusIndicatorForegroundColor,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      toolbarTextStyle: toolbarTextStyle ?? this.toolbarTextStyle,
      formulaBarTextStyle: formulaBarTextStyle ?? this.formulaBarTextStyle,
      gridHeaderTextStyle: gridHeaderTextStyle ?? this.gridHeaderTextStyle,
      gridCellTextStyle: gridCellTextStyle ?? this.gridCellTextStyle,
      tabActiveTextStyle: tabActiveTextStyle ?? this.tabActiveTextStyle,
      tabInactiveTextStyle: tabInactiveTextStyle ?? this.tabInactiveTextStyle,
      statusLabelTextStyle: statusLabelTextStyle ?? this.statusLabelTextStyle,
      statusBodyTextStyle: statusBodyTextStyle ?? this.statusBodyTextStyle,
      rowHeight: rowHeight ?? this.rowHeight,
      columnHeaderHeight: columnHeaderHeight ?? this.columnHeaderHeight,
      rowHeaderWidth: rowHeaderWidth ?? this.rowHeaderWidth,
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
      formulaBarHeight: formulaBarHeight ?? this.formulaBarHeight,
      tabAreaHeight: tabAreaHeight ?? this.tabAreaHeight,
    );
  }

  @override
  SheetifyThemeData lerp(ThemeExtension<SheetifyThemeData>? other, double t) {
    if (other is! SheetifyThemeData) return this;
    return SheetifyThemeData(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      gridLineColor: Color.lerp(gridLineColor, other.gridLineColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      headerBackgroundColor: Color.lerp(
        headerBackgroundColor,
        other.headerBackgroundColor,
        t,
      )!,
      headerForegroundColor: Color.lerp(
        headerForegroundColor,
        other.headerForegroundColor,
        t,
      )!,
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t)!,
      selectionBorderColor: Color.lerp(
        selectionBorderColor,
        other.selectionBorderColor,
        t,
      )!,
      searchHighlightColor: Color.lerp(
        searchHighlightColor,
        other.searchHighlightColor,
        t,
      )!,
      searchHighlightBorderColor: Color.lerp(
        searchHighlightBorderColor,
        other.searchHighlightBorderColor,
        t,
      )!,
      formulaBarBackgroundColor: Color.lerp(
        formulaBarBackgroundColor,
        other.formulaBarBackgroundColor,
        t,
      )!,
      formulaBarForegroundColor: Color.lerp(
        formulaBarForegroundColor,
        other.formulaBarForegroundColor,
        t,
      )!,
      cellTextColor: Color.lerp(cellTextColor, other.cellTextColor, t)!,
      statusIndicatorBackgroundColor: Color.lerp(
        statusIndicatorBackgroundColor,
        other.statusIndicatorBackgroundColor,
        t,
      )!,
      statusIndicatorForegroundColor: Color.lerp(
        statusIndicatorForegroundColor,
        other.statusIndicatorForegroundColor,
        t,
      )!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      success: Color.lerp(success, other.success, t)!,
      toolbarTextStyle: TextStyle.lerp(
        toolbarTextStyle,
        other.toolbarTextStyle,
        t,
      )!,
      formulaBarTextStyle: TextStyle.lerp(
        formulaBarTextStyle,
        other.formulaBarTextStyle,
        t,
      )!,
      gridHeaderTextStyle: TextStyle.lerp(
        gridHeaderTextStyle,
        other.gridHeaderTextStyle,
        t,
      )!,
      gridCellTextStyle: TextStyle.lerp(
        gridCellTextStyle,
        other.gridCellTextStyle,
        t,
      )!,
      tabActiveTextStyle: TextStyle.lerp(
        tabActiveTextStyle,
        other.tabActiveTextStyle,
        t,
      )!,
      tabInactiveTextStyle: TextStyle.lerp(
        tabInactiveTextStyle,
        other.tabInactiveTextStyle,
        t,
      )!,
      statusLabelTextStyle: TextStyle.lerp(
        statusLabelTextStyle,
        other.statusLabelTextStyle,
        t,
      )!,
      statusBodyTextStyle: TextStyle.lerp(
        statusBodyTextStyle,
        other.statusBodyTextStyle,
        t,
      )!,
      rowHeight: lerpDouble(rowHeight, other.rowHeight, t)!,
      columnHeaderHeight: lerpDouble(
        columnHeaderHeight,
        other.columnHeaderHeight,
        t,
      )!,
      rowHeaderWidth: lerpDouble(rowHeaderWidth, other.rowHeaderWidth, t)!,
      toolbarHeight: lerpDouble(toolbarHeight, other.toolbarHeight, t)!,
      formulaBarHeight: lerpDouble(
        formulaBarHeight,
        other.formulaBarHeight,
        t,
      )!,
      tabAreaHeight: lerpDouble(tabAreaHeight, other.tabAreaHeight, t)!,
    );
  }

  static double? lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
