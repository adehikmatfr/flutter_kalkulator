import '../models/calculator_model.dart';
import 'package:expressions/expressions.dart';

class CalculatorService {
  CalculatorModel model;

  CalculatorService(this.model);

  void appendNumber(String number) {
    if (model.displayValue == '0') {
      model.displayValue = number;
    } else {
      model.displayValue += number;
    }
  }

  void appendOperator(String operator) {
    model.history += '${model.displayValue} $operator ';
    model.displayValue = '0';
  }

  void calculate() {
    try {
      model.history += model.displayValue;
      final expression =
          model.history.replaceAll('x', '*').replaceAll('÷', '/');
      model.displayValue = _evaluateExpression(expression).toString();
      model.history = '';
    } catch (e) {
      model.displayValue = 'Error';
    }
  }

  void clear() {
    model.displayValue = '0';
    model.history = '';
  }

  double _evaluateExpression(String expression) {
    // Parse the expression using the expressions package
    final parsedExpression = Expression.parse(expression);

    // Evaluate the parsed expression
    const evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});

    // Return the result as a double
    return result.toDouble();
  }
}
