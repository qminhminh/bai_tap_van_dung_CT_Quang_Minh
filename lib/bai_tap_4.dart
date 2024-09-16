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
        backgroundColor: Colors.teal, // Thay đổi màu nền của AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _nController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nhập số n (số đoạn đường)',
                  border: const OutlineInputBorder(), // Đường viền cho ô nhập
                  prefixIcon: const Icon(Icons.numbers,
                      color: Colors.teal), // Biểu tượng bên trái
                  filled: true, // Màu nền cho ô nhập
                  fillColor: Colors.grey[200], // Màu nền
                ),
                style: const TextStyle(
                    fontSize: 16), // Kích thước chữ trong ô nhập
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _dataController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nhập khoảng cách giữa các đoạn (d1, d2, ..., dn)',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.list, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Màu nền của nút
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20), // Padding cho nút
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold), // Kiểu chữ
                ),
                child: const Text('Tính độ lệch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
