import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_alert_dialog.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  void _attemptLogin(BuildContext context) {
    if (emailController.text != 'admin' || passwordController.text != 'admin') {
      // Show the custom alert dialog when login fails
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: 'Login Failed',
            message: 'Incorrect username or password. Please try again.',
            buttonText: 'OK',
            onConfirm: () {},
            showCancelButton: false,
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Please login to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                hintText: 'Email',
                controller: emailController,
              ),
              CustomTextField(
                hintText: 'Password',
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Login',
                onPressed: () {
                  // Add login logic here
                  if (kDebugMode) {
                    print('Email: ${emailController.text}');
                    print('Password: ${passwordController.text}');
                  }
                  _attemptLogin(context);
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Add forgot password logic here
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navigate to the signup screen
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
