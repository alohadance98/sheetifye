import 'package:flutter/material.dart';
import 'package:sheetify/src/engine/layout/layout_engine.dart';
import 'package:sheetify/src/core/utils/grid_utils.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/core/theme/sheetify_theme_data.dart';

enum OverlayLayerType { selection, activeCell, editing, interaction, resize }

abstract class OverlayLayer {
  OverlayLayerType get type;
  bool get visible;
  void paint(Canvas canvas, Size size, OverlayContext context);
}

class OverlayContext {
  final Sheet sheet;
  final SheetifyThemeData theme;
  final GridCoordinate? activeCell;
  final GridRange? mainSelection;
  final List<GridRange> additionalSelections;
  final double scrollX;
  final double scrollY;
  final double headerWidth;
  final double headerHeight;
  final LayoutEngine layout;
  final String? searchQuery;

  OverlayContext({
    required this.sheet,
    required this.theme,
    this.activeCell,
    this.mainSelection,
    this.additionalSelections = const [],
    required this.scrollX,
    required this.scrollY,
    required this.headerWidth,
    required this.headerHeight,
    required this.layout,
    this.searchQuery,
  });
}

class OverlayManager {
  final List<OverlayLayer> _layers = [];

  void addLayer(OverlayLayer layer) {
    _layers.add(layer);
  }

  void paint(Canvas canvas, Size size, OverlayContext context) {
    for (final layer in _layers) {
      if (layer.visible) {
        layer.paint(canvas, size, context);
      }
    }
  }
}
