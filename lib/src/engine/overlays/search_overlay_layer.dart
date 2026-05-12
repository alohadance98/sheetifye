import 'package:flutter/material.dart';
import 'package:sheetify/src/engine/overlays/overlay_manager.dart';
import 'package:sheetify/src/engine/overlays/position_resolver.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';

class SearchOverlayLayer implements OverlayLayer {
  @override
  OverlayLayerType get type => OverlayLayerType.interaction;

  @override
  bool get visible => true;

  @override
  void paint(Canvas canvas, Size size, OverlayContext context) {
    final query = context.searchQuery;
    if (query == null || query.isEmpty) return;

    final highlightPaint = Paint()
      ..color = context.theme.searchHighlightColor.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = context.theme.searchHighlightBorderColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = SheetifyDimensions.gridStrokeWidth;

    final lowercaseQuery = query.toLowerCase();
    if (lowercaseQuery.isEmpty) return;

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(
      context.headerWidth,
      context.headerHeight,
      size.width - context.headerWidth,
      size.height - context.headerHeight,
    ));

    context.sheet.cells.forEach((address, cell) {
      final value = cell.value?.toString().toLowerCase() ?? '';
      if (value.contains(lowercaseQuery)) {
        final rect = PositionResolver.getCellRect(
          cell.row,
          cell.column,
          context.sheet,
          context.scrollX,
          context.scrollY,
          context.headerWidth,
          context.headerHeight,
          context.layout,
        );

        canvas.drawRect(rect, highlightPaint);
        canvas.drawRect(rect, borderPaint);
      }
    });

    canvas.restore();
  }
}
