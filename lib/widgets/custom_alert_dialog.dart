import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onConfirm;
  final bool showCancelButton;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onConfirm,
    this.showCancelButton = true, // Default to true if not specified
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.black87),
      ),
      actions: [
        if (showCancelButton)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onConfirm(); // Call the confirm function
          },
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
