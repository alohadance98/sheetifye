import 'package:flutter/material.dart';
import 'package:sheetifye/src/core/enums/cell_enums.dart';

@immutable
class Cell {
  final String id;
  final int row;
  final int column;
  final dynamic value;
  final String? rawInput;
  final String? formula;
  final CellStyle style;
  final CellValueType type;

  const Cell({
    required this.id,
    required this.row,
    required this.column,
    this.value,
    this.rawInput,
    this.formula,
    this.style = const CellStyle(),
    this.type = CellValueType.empty,
  });

  Cell copyWith({
    String? id,
    int? row,
    int? column,
    dynamic value,
    String? rawInput,
    String? formula,
    CellStyle? style,
    CellValueType? type,
  }) {
    return Cell(
      id: id ?? this.id,
      row: row ?? this.row,
      column: column ?? this.column,
      value: value ?? this.value,
      rawInput: rawInput ?? this.rawInput,
      formula: formula ?? this.formula,
      style: style ?? this.style,
      type: type ?? this.type,
    );
  }
}

@immutable
class CellStyle {
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final CellHorizontalAlignment horizontalAlignment;
  final CellVerticalAlignment verticalAlignment;
  final bool isBold;
  final bool isItalic;

  const CellStyle({
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.fontSize = 12.0,
    this.fontWeight = FontWeight.normal,
    this.horizontalAlignment = CellHorizontalAlignment.left,
    this.verticalAlignment = CellVerticalAlignment.center,
    this.isBold = false,
    this.isItalic = false,
  });

  CellStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    CellHorizontalAlignment? horizontalAlignment,
    CellVerticalAlignment? verticalAlignment,
    bool? isBold,
    bool? isItalic,
  }) {
    return CellStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      horizontalAlignment: horizontalAlignment ?? this.horizontalAlignment,
      verticalAlignment: verticalAlignment ?? this.verticalAlignment,
      isBold: isBold ?? this.isBold,
      isItalic: isItalic ?? this.isItalic,
    );
  }
}
