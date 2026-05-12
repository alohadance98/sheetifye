import 'package:flutter/material.dart';

enum ResizeDirection { horizontal, vertical }

class ResizeZone {
  final int index;
  final ResizeDirection direction;
  final Rect hitRect;

  ResizeZone({
    required this.index,
    required this.direction,
    required this.hitRect,
  });
}

class LayoutInteractionState {
  final ResizeZone? hoveredZone;
  final ResizeZone? activeResizeZone;
  final Offset? dragStartOffset;
  final double? initialSize;
  final Offset? lastDragPosition;

  LayoutInteractionState({
    this.hoveredZone,
    this.activeResizeZone,
    this.dragStartOffset,
    this.initialSize,
    this.lastDragPosition,
  });

  LayoutInteractionState copyWith({
    ResizeZone? hoveredZone,
    bool clearHover = false,
    ResizeZone? activeResizeZone,
    bool clearActive = false,
    Offset? dragStartOffset,
    double? initialSize,
    Offset? lastDragPosition,
  }) {
    return LayoutInteractionState(
      hoveredZone: clearHover ? null : (hoveredZone ?? this.hoveredZone),
      activeResizeZone:
          clearActive ? null : (activeResizeZone ?? this.activeResizeZone),
      dragStartOffset: dragStartOffset ?? this.dragStartOffset,
      initialSize: initialSize ?? this.initialSize,
      lastDragPosition: lastDragPosition ?? this.lastDragPosition,
    );
  }
}
