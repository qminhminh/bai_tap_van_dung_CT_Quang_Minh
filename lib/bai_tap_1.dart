// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _numberController = TextEditingController();
  String _draggedNumber = "";

  // List of numbers to be draggable
  final List<String> _numbers = ['11', '22', '21322113'];

  // Hàm giải mã chuỗi, tìm lại M từ N
  String decode(String encoded) {
    String current = encoded;

    while (true) {
      String next = '';
      int i = 0;

      while (i < current.length) {
        int repeatCount = int.parse(current[i]);
        String digit = current[i + 1];
        next += digit * repeatCount;
        i += 2;
      }

      if (next.length <= 3) {
        return next;
      }

      current = next;
    }
  }

  // Function to show result in a dialog
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Số gốc m',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text(
            result,
            style: TextStyle(
                fontFamily: FontWeight.bold.toString(),
                color: Colors.blue,
                fontSize: 30),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Chức năng hiển thị lỗi trong hộp thoại
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

  // Handle decoding input
  void _decodeInput() {
    String a = '';
    final String input = _numberController.text;
    if (input.isEmpty) {
      a = _draggedNumber;
    }

    try {
      final String result = decode(a);
      _showResultDialog(result);
    } catch (e) {
      _showErrorDialog('Một lỗi đã xảy ra trong khi giải mã.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải mã số'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nhập số được mã hóa:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Số được mã hóa',
                prefixIcon: Icon(Icons.lock),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _decodeInput,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Giải mã',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Draggable Widgets for each number in the list
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _numbers.map((number) {
                return Draggable<String>(
                  data: number,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.blueAccent,
                    child: Text(
                      number,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  feedback: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.blueAccent.withOpacity(0.5),
                    child: Text(
                      number,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  childWhenDragging: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey,
                    child: Text(
                      number,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Drag Target Widget
            DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  _draggedNumber = data;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 100,
                  color: Colors.blueGrey,
                  child: Center(
                    child: Text(
                      _draggedNumber.isEmpty
                          ? 'Kéo và thả số vào đây'
                          : 'Số đã kéo: $_draggedNumber',
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
