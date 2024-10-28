import '../models/bmi_calculator_model.dart';

class BMICalculatorService {
  BMICalculatorModel model;

  BMICalculatorService(this.model);

  void appendHeightValue(String s) {
    model.height = s;
  }

  void appendWeightValue(String s) {
    model.weight = s;
  }

  void calculate() {
    final heightCm = double.tryParse(model.height) ?? 0;
    final weight = double.tryParse(model.weight) ?? 0;

    if (heightCm > 0 && weight > 0) {
      // Convert height from cm to meters
      final heightMeters = heightCm / 100;
      final bmi = weight / (heightMeters * heightMeters);
      final category = _getBMICategory(bmi);

      model.displayValue = "Your BMI is ${bmi.toStringAsFixed(2)} ($category)";
    } else {
      model.displayValue = "Please enter valid values for height and weight.";
    }
  }

  void clear() {
    model.height = '0';
    model.weight = '0';
    model.displayValue = '';
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 24.9) {
      return "Normal weight";
    } else if (bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }
}
