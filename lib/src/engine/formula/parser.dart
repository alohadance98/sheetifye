import 'package:sheetifye/src/engine/formula/formula_ast.dart';
import 'package:sheetifye/src/core/utils/grid_utils.dart';

class FormulaParser {
  final List<FormulaToken> tokens;
  int _current = 0;

  FormulaParser(this.tokens);

  ASTNode parse() {
    if (tokens.isEmpty) return LiteralNode(null);
    if (tokens[0].type == FormulaTokenType.equals) {
      _current++; // Consume '='
    }
    return _expression();
  }

  ASTNode _expression() {
    return _addition();
  }

  ASTNode _addition() {
    var node = _multiplication();
    while (_match([FormulaTokenType.plus, FormulaTokenType.minus])) {
      final operator = _previous().value;
      final right = _multiplication();
      node = BinaryExpressionNode(node, operator, right);
    }
    return node;
  }

  ASTNode _multiplication() {
    var node = _primary();
    while (_match([FormulaTokenType.star, FormulaTokenType.slash])) {
      final operator = _previous().value;
      final right = _primary();
      node = BinaryExpressionNode(node, operator, right);
    }
    return node;
  }

  ASTNode _primary() {
    if (_match([FormulaTokenType.number])) {
      return LiteralNode(double.parse(_previous().value));
    }
    if (_match([FormulaTokenType.string])) {
      return LiteralNode(_previous().value);
    }
    if (_match([FormulaTokenType.reference])) {
      final ref = _previous().value;
      if (_peek().type == FormulaTokenType.colon) {
        _advance(); // Consume ':'
        if (_match([FormulaTokenType.reference])) {
          final endRef = _previous().value;
          return RangeReferenceNode(
            '$ref:$endRef',
            GridUtils.parseRange('$ref:$endRef'),
          );
        }
      }
      final coord = GridUtils.parseAddress(ref);
      return CellReferenceNode(ref, coord.row, coord.column);
    }
    if (_match([FormulaTokenType.function])) {
      final name = _previous().value;
      _consume(FormulaTokenType.leftParen, "Expect '(' after function name.");
      final args = <ASTNode>[];
      if (!_check(FormulaTokenType.rightParen)) {
        do {
          args.add(_expression());
        } while (_match([FormulaTokenType.comma]));
      }
      _consume(FormulaTokenType.rightParen, "Expect ')' after arguments.");
      return FunctionCallNode(name, args);
    }
    if (_match([FormulaTokenType.leftParen])) {
      final node = _expression();
      _consume(FormulaTokenType.rightParen, "Expect ')' after expression.");
      return node;
    }

    throw Exception("Unexpected token: ${_peek().value}");
  }

  bool _match(List<FormulaTokenType> types) {
    for (final type in types) {
      if (_check(type)) {
        _advance();
        return true;
      }
    }
    return false;
  }

  bool _check(FormulaTokenType type) {
    if (_isAtEnd()) return false;
    return _peek().type == type;
  }

  FormulaToken _advance() {
    if (!_isAtEnd()) _current++;
    return _previous();
  }

  bool _isAtEnd() => _peek().type == FormulaTokenType.eof;
  FormulaToken _peek() => tokens[_current];
  FormulaToken _previous() => tokens[_current - 1];

  void _consume(FormulaTokenType type, String message) {
    if (_check(type)) {
      _advance();
      return;
    }
    throw Exception(message);
  }
}
