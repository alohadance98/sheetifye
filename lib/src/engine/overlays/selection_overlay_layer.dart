import 'dart:ui';
import 'package:sheetify/src/engine/overlays/overlay_manager.dart';
import 'package:sheetify/src/engine/overlays/position_resolver.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';

class SelectionOverlayLayer implements OverlayLayer {
  @override
  OverlayLayerType get type => OverlayLayerType.selection;

  @override
  bool get visible => true;

  @override
  void paint(Canvas canvas, Size size, OverlayContext context) {
    if (context.mainSelection == null) return;

    final fillPaint = Paint()
      ..color = context.theme.selectionColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = context.theme.selectionBorderColor.withOpacity(0.5)
      ..strokeWidth = SheetifyDimensions.gridStrokeWidth
      ..style = PaintingStyle.stroke;

    // Paint main selection
    var selection = context.mainSelection!;

    // Expand selection to include full merged regions
    bool expanded = true;
    while (expanded) {
      expanded = false;
      for (final region in context.sheet.mergedCells.regions) {
        if (selection.intersects(region.range) &&
            !selection.containsRange(region.range)) {
          selection = selection.expandToInclude(region.range);
          expanded = true;
        }
      }
    }

    final rect = PositionResolver.getRangeRect(
      selection,
      context.sheet,
      context.scrollX,
      context.scrollY,
      context.headerWidth,
      context.headerHeight,
      context.layout,
    );

    // Clip to viewport (avoid drawing over headers)
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(
        context.headerWidth,
        context.headerHeight,
        size.width - context.headerWidth,
        size.height - context.headerHeight,
      ),
    );

    // Draw the fill, but punch out the active cell if it's inside the selection
    if (context.activeCell != null &&
        selection.contains(
          context.activeCell!.row,
          context.activeCell!.column,
        )) {
      final activeCellRect = PositionResolver.getCellRect(
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
      // Clip out the active cell area
      canvas.clipRect(activeCellRect, clipOp: ClipOp.difference);
      canvas.drawRect(rect, fillPaint);
      canvas.restore();
    } else {
      canvas.drawRect(rect, fillPaint);
    }

    canvas.drawRect(rect, borderPaint);

    // Paint additional selections
    for (final selection in context.additionalSelections) {
      final sRect = PositionResolver.getRangeRect(
        selection,
        context.sheet,
        context.scrollX,
        context.scrollY,
        context.headerWidth,
        context.headerHeight,
        context.layout,
      );
      canvas.drawRect(sRect, fillPaint);
      canvas.drawRect(sRect, borderPaint);
    }

    canvas.restore();
  }
}
