import 'package:flutter/material.dart';
import 'package:sheetify/src/engine/overlays/overlay_manager.dart';
import 'package:sheetify/src/engine/overlays/position_resolver.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';

class ActiveCellOverlayLayer implements OverlayLayer {
  @override
  OverlayLayerType get type => OverlayLayerType.activeCell;

  @override
  bool get visible => true;

  @override
  void paint(Canvas canvas, Size size, OverlayContext context) {
    if (context.activeCell == null) return;

    final paint = Paint()
      ..color = context.theme.selectionBorderColor
      ..strokeWidth = SheetifyDimensions.activeCellStrokeWidth
      ..style = PaintingStyle.stroke;

    final rect = PositionResolver.getCellRect(
      context.activeCell!.row,
      context.activeCell!.column,
      context.sheet,
      context.scrollX,
      context.scrollY,
      context.headerWidth,
      context.headerHeight,
      context.layout,
    );

    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(
        context.headerWidth,
        context.headerHeight,
        size.width - context.headerWidth,
        size.height - context.headerHeight,
      ),
    );

    canvas.drawRect(rect, paint);

    // Draw active cell handle
    const handleSize = SheetifyDimensions.selectionHandleSize;
    final handleRect = Rect.fromCenter(
      center: rect.bottomRight,
      width: handleSize,
      height: handleSize,
    );
    final handlePaint = Paint()
      ..color = context.theme.selectionBorderColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(handleRect, handlePaint);

    canvas.restore();
  }
}
