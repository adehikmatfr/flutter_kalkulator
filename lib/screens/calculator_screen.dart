import 'package:flutter/material.dart';
import '../models/calculator_model.dart';
import '../services/calculator_service.dart';
import '../widgets/custom_calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  late CalculatorModel model;
  late CalculatorService calculatorService;

  @override
  void initState() {
    super.initState();
    model = CalculatorModel();
    calculatorService = CalculatorService(model);
  }

  void _updateDisplay() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: SafeArea(
        // Wrap the main layout in a SafeArea
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black12,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      model.history,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      model.displayValue,
                      style: const TextStyle(fontSize: 48, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            _buildButtonRow(['7', '8', '9', '÷']),
            _buildButtonRow(['4', '5', '6', 'x']),
            _buildButtonRow(['1', '2', '3', '-']),
            _buildButtonRow(['C', '0', '=', '+']),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        return CustomCalculatorButton(
          text: text,
          onPressed: () {
            if (text == 'C') {
              calculatorService.clear();
            } else if (text == '=') {
              calculatorService.calculate();
            } else if (['+', '-', 'x', '÷'].contains(text)) {
              calculatorService.appendOperator(text);
            } else {
              calculatorService.appendNumber(text);
            }
            _updateDisplay();
          },
        );
      }).toList(),
    );
  }
}
