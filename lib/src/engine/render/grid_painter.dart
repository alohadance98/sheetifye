import 'package:flutter/material.dart';
import 'package:sheetifye/src/core/theme/sheetifye_theme_data.dart';
import 'package:sheetifye/src/core/theme/sheetifye_dimensions.dart';
import 'package:sheetifye/src/core/theme/sheetifye_spacing_tokens.dart';
import 'package:sheetifye/src/engine/virtualization/virtualization_engine.dart';
import 'package:sheetifye/src/engine/render/text_painter_cache.dart';
import 'package:sheetifye/src/engine/layout/layout_engine.dart';
import 'package:sheetifye/src/domain/entities/workbook.dart';

class GridPainter extends CustomPainter {
  final Sheet sheet;
  final ViewportRange viewportRange;
  final SheetifyeThemeData theme;
  final double scrollX;
  final double scrollY;
  final TextPainterCache textPainterCache;
  final LayoutEngine layout;

  GridPainter({
    required this.sheet,
    required this.viewportRange,
    required this.theme,
    required this.scrollX,
    required this.scrollY,
    required this.textPainterCache,
    required this.layout,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawGridLines(canvas, size);
    _drawCells(canvas, size);
  }

  void _drawGridLines(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.gridLineColor
      ..strokeWidth = SheetifyeDimensions.gridStrokeWidth;

    // Draw vertical lines
    for (
      int c = viewportRange.startColumn;
      c <= viewportRange.endColumn + 1;
      c++
    ) {
      double x = layout.getColumnOffset(c, sheet.columnCount) - scrollX;
      if (x >= 0 && x <= size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
    }

    // Draw horizontal lines
    for (int r = viewportRange.startRow; r <= viewportRange.endRow + 1; r++) {
      double y = layout.getRowOffset(r, sheet) - scrollY;
      if (y >= 0 && y <= size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }
  }

  void _drawCells(Canvas canvas, Size size) {
    for (int vR = viewportRange.startRow; vR <= viewportRange.endRow; vR++) {
      final logicalR = sheet.rowIndexManager.getLogicalIndex(vR);
      if (logicalR == -1) continue;

      for (
        int c = viewportRange.startColumn;
        c <= viewportRange.endColumn;
        c++
      ) {
        if (sheet.mergedCells.isHidden(logicalR, c)) continue;

        final cell = sheet.cells['$logicalR,$c'];
        final double x = layout.getColumnOffset(c, sheet.columnCount) - scrollX;
        final double y = layout.getRowOffset(vR, sheet) - scrollY;

        double cellWidth = 0;
        double cellHeight = 0;

        final merge = sheet.mergedCells.getRegionFor(logicalR, c);
        if (merge != null) {
          for (int r = merge.range.minRow; r <= merge.range.maxRow; r++) {
            final vRow = sheet.rowIndexManager.getVisualIndex(r);
            if (vRow != -1) cellHeight += layout.getRowHeight(vRow, sheet);
          }
          for (int col = merge.range.minCol; col <= merge.range.maxCol; col++) {
            cellWidth += layout.getColumnWidth(col, sheet);
          }
        } else {
          cellWidth = layout.getColumnWidth(c, sheet);
          cellHeight = layout.getRowHeight(vR, sheet);
        }

        if (x + cellWidth < 0 || x > size.width) continue;
        if (y + cellHeight < 0 || y > size.height) continue;

        // Draw background
        if (merge != null || (cell != null && cell.value != null)) {
          canvas.drawRect(
            Rect.fromLTWH(
              x + SheetifyeDimensions.gridStrokeWidth,
              y + SheetifyeDimensions.gridStrokeWidth,
              cellWidth - SheetifyeDimensions.gridStrokeWidth,
              cellHeight - SheetifyeDimensions.gridStrokeWidth,
            ),
            Paint()..color = theme.surfaceColor,
          );
        }

        if (cell != null && cell.value != null) {
          const horizontalPadding = SheetifyeSpacingTokens.small;
          final painter = textPainterCache.getOrCreate(
            text: cell.value.toString(),
            style: theme.gridCellTextStyle,
            maxWidth: cellWidth - (horizontalPadding * 2),
          );

          painter.paint(
            canvas,
            Offset(
              x + horizontalPadding,
              y + (cellHeight - painter.height) / 2,
            ),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.sheet != sheet ||
        oldDelegate.viewportRange != viewportRange ||
        oldDelegate.scrollX != scrollX ||
        oldDelegate.scrollY != scrollY ||
        oldDelegate.theme != theme ||
        oldDelegate.layout != layout;
  }
}
