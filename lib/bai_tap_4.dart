import 'dart:math';

import 'package:flutter/material.dart';

class BaiTap04 extends StatefulWidget {
  const BaiTap04({super.key});

  @override
  State<BaiTap04> createState() => _BaiTap04State();
}

class _BaiTap04State extends State<BaiTap04> {
  final TextEditingController _nController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  void _showResult(String result) {
    // Hàm này hiển thị kết quả trong popup
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả'),
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

  // tính độ lêch nhỏ nhất giữa các phần tử liên tiếp
  void _processData() {
    // Lấy dữ liệu từ TextField và xử lý
    int n = int.tryParse(_nController.text) ?? 0;
    List<int> distances = _dataController.text
        .split(',')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    if (n <= 1 || distances.length != n) {
      _showResult('Dữ liệu không hợp lệ');
      return;
    }

    // Sắp xếp dãy số
    distances.sort();

    // Tìm độ lệch nhỏ nhất giữa các phần tử liên tiếp
    int mins = distances[1] - distances[0];
    for (int i = 1; i < n - 1; i++) {
      int diff = distances[i + 1] - distances[i];
      mins = min(mins, diff);
    }

    // Hiển thị kết quả trong popup
    _showResult('Độ lệch nhỏ nhất: $mins');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính độ lệch giao thông'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số n (số đoạn đường)',
              ),
            ),
            TextField(
              controller: _dataController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập khoảng cách giữa các đoạn (d1, d2, ..., dn)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processData,
              child: const Text('Tính độ lệch'),
            ),
          ],
        ),
      ),
    );
  }
}
