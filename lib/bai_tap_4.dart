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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool check = false; // Biến kiểm tra để quyết định hiển thị button nào

  void _showResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text(result,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 30)),
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

  void _processData() {
    if (_formKey.currentState?.validate() ?? false) {
      int n = int.tryParse(_nController.text) ?? 0;
      List<int> distances = _dataController.text
          .split(',')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();

      distances.sort();

      int mins = distances[1] - distances[0];
      for (int i = 1; i < n - 1; i++) {
        int diff = distances[i + 1] - distances[i];
        mins = min(mins, diff);
      }

      _showResult('Độ lệch nhỏ nhất: $mins');
    }
  }

  void _onButtonPressed() {
    setState(() {
      check = !check; // Đổi trạng thái để chuyển giữa hai button
    });

    if (check) {
      _processData(); // Khi hiển thị button thứ hai, gọi hàm hiển thị kết quả
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính độ lệch giao thông'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nhập số n (số đoạn đường)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers, color: Colors.teal),
                        filled: true,
                        fillColor: Color.fromARGB(255, 104, 179, 197),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dataController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText:
                            'Nhập khoảng cách giữa các đoạn (d1, d2, ..., dn)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.list, color: Colors.teal),
                        filled: true,
                        fillColor: Color.fromARGB(255, 104, 179, 197),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Sử dụng Row để căn chỉnh các button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Button đầu tiên nằm bên trái
                  if (!check)
                    ElevatedButton(
                      onPressed: _onButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Hiện Kết Quả'),
                    ),

                  // Button thứ hai nằm bên phải
                  if (check)
                    Container(
                      margin: const EdgeInsets.only(left: 220),
                      child: ElevatedButton(
                        onPressed: _onButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Nhấn 2 lần'),
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
