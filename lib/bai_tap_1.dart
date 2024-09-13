// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _numberController = TextEditingController();

  // Function to find the original number M
  void _findM(String n) {
    String prevN;
    while (true) {
      prevN = n;
      n = _decode(n);
      if (n == prevN) break;
    }
    _showResultDialog(n);
  }

  // Helper function to decode the number
  String _decode(String n) {
    String result = '';
    int count = 1;
    for (int i = 1; i < n.length; i++) {
      if (n[i] == n[i - 1]) {
        count++;
      } else {
        result += '$count${n[i - 1]}';
        count = 1;
      }
    }
    result += '$count${n[n.length - 1]}';
    return result;
  }

  void _decodeInput() {
    String input = _numberController.text.trim();

    // Validate input: check if it's non-empty and only digits
    if (input.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(input)) {
      _showErrorDialog("Please enter a valid encoded number (digits only).");
      return;
    }

    // Find the original number M
    try {
      _findM(input);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  // Function to show result in a dialog
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Original Number M'),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show error in a dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decode Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter encoded number N',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _decodeInput,
              child: const Text('Decode'),
            ),
          ],
        ),
      ),
    );
  }
}
