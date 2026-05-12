import 'package:sheetify/src/core/utils/grid_utils.dart';

class SelectionEngine {
  GridCoordinate? activeCell;
  GridRange? mainSelection;
  List<GridRange> additionalSelections = [];

  bool isDragging = false;

  void selectCell(GridCoordinate coordinate, {bool multiSelect = false}) {
    if (!multiSelect) {
      additionalSelections.clear();
      activeCell = coordinate;
      mainSelection = GridRange(start: coordinate, end: coordinate);
    } else {
      if (mainSelection != null) {
        additionalSelections.add(mainSelection!);
      }
      activeCell = coordinate;
      mainSelection = GridRange(start: coordinate, end: coordinate);
    }
  }

  void startDrag(GridCoordinate coordinate) {
    isDragging = true;
    selectCell(coordinate);
  }

  void updateDrag(GridCoordinate coordinate) {
    if (isDragging && activeCell != null) {
      mainSelection = GridRange(start: activeCell!, end: coordinate);
    }
  }

  void endDrag() {
    isDragging = false;
  }

  void clear() {
    activeCell = null;
    mainSelection = null;
    additionalSelections.clear();
    isDragging = false;
  }

  bool isSelected(int row, int col) {
    if (mainSelection?.contains(row, col) ?? false) return true;
    for (final range in additionalSelections) {
      if (range.contains(row, col)) return true;
    }
    return false;
  }
}
