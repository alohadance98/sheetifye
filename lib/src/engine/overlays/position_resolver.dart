import 'package:flutter/material.dart';
import 'package:sheetify/src/core/utils/grid_utils.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/engine/layout/layout_engine.dart';

class PositionResolver {
  static Rect getCellRect(
    int row,
    int col,
    Sheet sheet,
    double scrollX,
    double scrollY,
    double headerWidth,
    double headerHeight,
    LayoutEngine layout,
  ) {
    final region = sheet.mergedCells.getRegionFor(row, col);
    final targetRow = region?.range.minRow ?? row;
    final targetCol = region?.range.minCol ?? col;

    final double left =
        layout.getColumnOffset(targetCol, sheet.columnCount) +
        headerWidth -
        scrollX;
    final double top =
        layout.getRowOffset(targetRow, sheet) + headerHeight - scrollY;

    double width = 0;
    double height = 0;

    if (region != null) {
      for (int i = region.range.minCol; i <= region.range.maxCol; i++) {
        width += layout.getColumnWidth(i, sheet);
      }
      for (int i = region.range.minRow; i <= region.range.maxRow; i++) {
        height += layout.getRowHeight(i, sheet);
      }
    } else {
      width = layout.getColumnWidth(col, sheet);
      height = layout.getRowHeight(row, sheet);
    }

    return Rect.fromLTWH(left, top, width, height);
  }

  static Rect getRangeRect(
    GridRange range,
    Sheet sheet,
    double scrollX,
    double scrollY,
    double headerWidth,
    double headerHeight,
    LayoutEngine layout,
  ) {
    final startRect = getCellRect(
      range.minRow,
      range.minCol,
      sheet,
      scrollX,
      scrollY,
      headerWidth,
      headerHeight,
      layout,
    );
    final endRect = getCellRect(
      range.maxRow,
      range.maxCol,
      sheet,
      scrollX,
      scrollY,
      headerWidth,
      headerHeight,
      layout,
    );

    return Rect.fromPoints(startRect.topLeft, endRect.bottomRight);
  }
}
