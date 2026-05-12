import 'dart:math';
import 'package:sheetifye/src/engine/layout/layout_engine.dart';

class ViewportRange {
  final int startRow;
  final int endRow;
  final int startColumn;
  final int endColumn;

  const ViewportRange({
    required this.startRow,
    required this.endRow,
    required this.startColumn,
    required this.endColumn,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewportRange &&
          runtimeType == other.runtimeType &&
          startRow == other.startRow &&
          endRow == other.endRow &&
          startColumn == other.startColumn &&
          endColumn == other.endColumn;

  @override
  int get hashCode =>
      startRow.hashCode ^
      endRow.hashCode ^
      startColumn.hashCode ^
      endColumn.hashCode;
}

class VirtualizationEngine {
  final LayoutEngine layout;

  VirtualizationEngine({required this.layout});

  ViewportRange calculateViewportRange({
    required double scrollX,
    required double scrollY,
    required double viewportWidth,
    required double viewportHeight,
    required int totalRows,
    required int totalCols,
    int buffer = 2,
  }) {
    final startCol = layout.getColumnIndex(scrollX, totalCols);
    final endCol = layout.getColumnIndex(scrollX + viewportWidth, totalCols);

    final startRow = layout.getRowIndex(scrollY, totalRows);
    final endRow = layout.getRowIndex(scrollY + viewportHeight, totalRows);

    return ViewportRange(
      startRow: max(0, startRow - buffer),
      endRow: min(totalRows - 1, endRow + buffer),
      startColumn: max(0, startCol - buffer),
      endColumn: min(totalCols - 1, endCol + buffer),
    );
  }
}
