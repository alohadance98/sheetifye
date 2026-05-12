import 'package:sheetify/sheetify.dart';
import 'package:sheetify/src/engine/layout/metrics_manager.dart';
import 'package:sheetify/src/core/constants/sheetify_constants.dart';

class LayoutEngine {
  final MetricsManager rows;
  final MetricsManager columns;

  double _zoomScale = 1.0;

  LayoutEngine({
    double defaultRowHeight = SheetifyConstants.defaultRowHeight,
    double defaultColumnWidth = SheetifyConstants.defaultColumnWidth,
  }) : rows = MetricsManager(defaultSize: defaultRowHeight),
       columns = MetricsManager(defaultSize: defaultColumnWidth);

  double get zoomScale => _zoomScale;
  void setZoom(double scale) {
    _zoomScale = scale;
  }

  // Optimized Row Helpers (O(log Overrides))
  double getRowOffset(int visualRow, Sheet sheet) {
    // For now, if no sorting, visualRow == logicalRow.
    // If sorting exists, we need to map visual to logical.
    // But offset calculation must handle the cumulative heights.
    
    // Simplification: use MetricsManager which handles sparse cumulative logic.
    return rows.getOffset(visualRow, sheet.rowCount) * _zoomScale;
  }

  double getRowHeight(int visualRow, Sheet sheet) {
    final logicalRow = sheet.rowIndexManager.getLogicalIndex(visualRow);
    return rows.getSize(logicalRow) * _zoomScale;
  }

  int getRowIndex(double offset, int totalRows) =>
      rows.getIndex(offset / _zoomScale, totalRows);

  // Optimized Column Helpers (O(log Overrides))
  double getColumnOffset(int index, int totalCols) =>
      columns.getOffset(index, totalCols) * _zoomScale;
      
  double getColumnWidth(int visualCol, Sheet sheet) {
    return columns.getSize(visualCol) * _zoomScale;
  }

  int getColumnIndex(double offset, int totalCols) =>
      columns.getIndex(offset / _zoomScale, totalCols);

  double getTotalWidth(int totalCols) =>
      columns.getTotalSize(totalCols) * _zoomScale;
      
  double getTotalHeight(int totalRows) =>
      rows.getTotalSize(totalRows) * _zoomScale;
}
