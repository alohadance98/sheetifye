import 'package:sheetify/src/engine/formula/formula_ast.dart';
import 'package:sheetify/src/core/utils/grid_utils.dart';
import 'package:sheetify/src/engine/formula/tokenizer.dart';
import 'package:sheetify/src/engine/formula/parser.dart';

class ReferenceShiftEngine {
  String shiftFormula(String formula, {int? rowAt, int? rowCount, int? colAt, int? colCount}) {
    if (!formula.startsWith('=')) return formula;

    try {
      final tokens = FormulaTokenizer(formula).tokenize();
      final ast = FormulaParser(tokens).parse();
      final visitor = _ReferenceShiftVisitor(
        rowAt: rowAt,
        rowCount: rowCount ?? 0,
        colAt: colAt,
        colCount: colCount ?? 0,
      );
      return '=' + ast.accept(visitor);
    } catch (e) {
      return formula; // Return original if parsing fails during shift
    }
  }
}

class _ReferenceShiftVisitor implements ASTVisitor<String> {
  final int? rowAt;
  final int rowCount;
  final int? colAt;
  final int colCount;

  _ReferenceShiftVisitor({
    this.rowAt,
    this.rowCount = 0,
    this.colAt,
    this.colCount = 0,
  });

  @override
  String visitLiteral(LiteralNode node) {
    if (node.value is String) return '"${node.value}"';
    return node.value.toString();
  }

  @override
  String visitCellReference(CellReferenceNode node) {
    int r = node.row;
    int c = node.col;

    if (rowAt != null && r >= rowAt!) {
      r += rowCount;
    }
    if (colAt != null && c >= colAt!) {
      c += colCount;
    }

    if (r < 0 || c < 0) return '#REF!';
    return GridUtils.getAddress(r, c);
  }

  @override
  String visitRangeReference(RangeReferenceNode node) {
    int minR = node.range.minRow;
    int maxR = node.range.maxRow;
    int minC = node.range.minCol;
    int maxC = node.range.maxCol;

    if (rowAt != null) {
      if (minR >= rowAt!) minR += rowCount;
      if (maxR >= rowAt!) maxR += rowCount;
    }
    if (colAt != null) {
      if (minC >= colAt!) minC += colCount;
      if (maxC >= colAt!) maxC += colCount;
    }

    if (minR < 0 || minC < 0) return '#REF!';
    return '${GridUtils.getAddress(minR, minC)}:${GridUtils.getAddress(maxR, maxC)}';
  }

  @override
  String visitBinaryExpression(BinaryExpressionNode node) {
    return '(${node.left.accept(this)} ${node.operator} ${node.right.accept(this)})';
  }

  @override
  String visitFunctionCall(FunctionCallNode node) {
    final args = node.arguments.map((a) => a.accept(this)).join(',');
    return '${node.name}($args)';
  }
}
