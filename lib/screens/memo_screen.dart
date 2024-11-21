import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  final List<Map<String, String>> memosList = []; // List to store memos
  String selectedDate = "Pick a date";
  String selectedTime = "Pick a time";
  final TextEditingController memoController = TextEditingController();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate.toLocal().toString().split(' ')[0];
      });
      showToast("Selected Date: $selectedDate");
    }
  }

  void pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime.format(context);
      });
      showToast("Selected Time: $selectedTime");
    }
  }

  void addMemo() {
    if (selectedDate == "Pick a date" ||
        selectedTime == "Pick a time" ||
        memoController.text.isEmpty) {
      showSnackbar(context, "Please fill all fields!");
      return;
    }

    setState(() {
      memosList.add({
        "date": selectedDate,
        "time": selectedTime,
        "memo": memoController.text,
      });
      selectedDate = "Pick a date";
      selectedTime = "Pick a time";
      memoController.clear();
    });

    showSnackbar(context, "Memo added!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Memo',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            textAlign: TextAlign.center,
          ),
          // Input Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: pickDate,
                    child: Text(selectedDate),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: pickTime,
                    child: Text(selectedTime),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: memoController,
                    decoration: const InputDecoration(
                      labelText: "Enter Memo",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: addMemo,
                    child: const Text("Add Memo"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // List of Memos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                itemCount: memosList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final memo = memosList[index];
                  return ListTile(
                    title: Text(
                      "${memo['date']} at ${memo['time']}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(memo['memo'] ?? ""),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          memosList.removeAt(index);
                        });
                        showToast("Deleted memo");
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
