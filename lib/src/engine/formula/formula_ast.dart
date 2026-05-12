import 'package:sheetifye/src/core/utils/grid_utils.dart';

enum FormulaTokenType {
  equals,
  plus,
  minus,
  star,
  slash,
  leftParen,
  rightParen,
  comma,
  colon,
  number,
  string,
  reference, // A1, $A$1
  function, // SUM, IF
  eof,
}

class FormulaToken {
  final FormulaTokenType type;
  final String value;
  final int position;

  FormulaToken(this.type, this.value, this.position);

  @override
  String toString() => 'Token($type, "$value")';
}

abstract class ASTNode {
  T accept<T>(ASTVisitor<T> visitor);
}

class LiteralNode extends ASTNode {
  final dynamic value;
  LiteralNode(this.value);
  @override
  T accept<T>(ASTVisitor<T> visitor) => visitor.visitLiteral(this);
}

class CellReferenceNode extends ASTNode {
  final String address;
  final int row;
  final int col;
  CellReferenceNode(this.address, this.row, this.col);
  @override
  T accept<T>(ASTVisitor<T> visitor) => visitor.visitCellReference(this);
}

class RangeReferenceNode extends ASTNode {
  final String address;
  final GridRange range;
  RangeReferenceNode(this.address, this.range);
  @override
  T accept<T>(ASTVisitor<T> visitor) => visitor.visitRangeReference(this);
}

class BinaryExpressionNode extends ASTNode {
  final ASTNode left;
  final String operator;
  final ASTNode right;
  BinaryExpressionNode(this.left, this.operator, this.right);
  @override
  T accept<T>(ASTVisitor<T> visitor) => visitor.visitBinaryExpression(this);
}

class FunctionCallNode extends ASTNode {
  final String name;
  final List<ASTNode> arguments;
  FunctionCallNode(this.name, this.arguments);
  @override
  T accept<T>(ASTVisitor<T> visitor) => visitor.visitFunctionCall(this);
}

abstract class ASTVisitor<T> {
  T visitLiteral(LiteralNode node);
  T visitCellReference(CellReferenceNode node);
  T visitRangeReference(RangeReferenceNode node);
  T visitBinaryExpression(BinaryExpressionNode node);
  T visitFunctionCall(FunctionCallNode node);
}
