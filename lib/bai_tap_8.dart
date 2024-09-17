// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class BaiTap08 extends StatefulWidget {
  const BaiTap08({super.key});

  @override
  State<BaiTap08> createState() => _BaiTap08State();
}

class _BaiTap08State extends State<BaiTap08> {
  final TextEditingController x1Controller = TextEditingController();
  final TextEditingController y1Controller = TextEditingController();
  final TextEditingController x2Controller = TextEditingController();
  final TextEditingController y2Controller = TextEditingController();
  final TextEditingController x3Controller = TextEditingController();
  final TextEditingController y3Controller = TextEditingController();
  final TextEditingController a1Controller = TextEditingController();
  final TextEditingController b1Controller = TextEditingController();
  final TextEditingController c1Controller = TextEditingController();
  final TextEditingController a2Controller = TextEditingController();
  final TextEditingController b2Controller = TextEditingController();
  final TextEditingController c2Controller = TextEditingController();
  final TextEditingController a3Controller = TextEditingController();
  final TextEditingController b3Controller = TextEditingController();
  final TextEditingController c3Controller = TextEditingController();

  String result = "";

  void calculateCost() {
    // Parse inputs from controllers
    int X1 = int.parse(x1Controller.text);
    int Y1 = int.parse(y1Controller.text);
    int X2 = int.parse(x2Controller.text);
    int Y2 = int.parse(y2Controller.text);
    int X3 = int.parse(x3Controller.text);
    int Y3 = int.parse(y3Controller.text);

    int A1 = int.parse(a1Controller.text);
    int B1 = int.parse(b1Controller.text);
    int C1 = int.parse(c1Controller.text);
    int A2 = int.parse(a2Controller.text);
    int B2 = int.parse(b2Controller.text);
    int C2 = int.parse(c2Controller.text);
    int A3 = int.parse(a3Controller.text);
    int B3 = int.parse(b3Controller.text);
    int C3 = int.parse(c3Controller.text);

    // Calculate usage
    int usage1 = Y1 - X1;
    int usage2 = Y2 - X2;
    int usage3 = Y3 - X3;

    int totalCost = 0;

    // Tính chi phí cho hộ gia đình (loại 1)
    if (usage1 <= 50) {
      // Nếu mức tiêu thụ nhỏ hơn hoặc bằng 50 kWh, chi phí tính bằng giá A1 cho mỗi kWh.
      totalCost += usage1 * A1;
    } else if (usage1 <= 150) {
      // Nếu mức tiêu thụ lớn hơn 50 kWh và nhỏ hơn hoặc bằng 150 kWh:
      // - Tính chi phí cho 50 kWh đầu tiên theo giá A1.
      // - Tính chi phí cho phần mức tiêu thụ vượt quá 50 kWh (từ 51 đến 150) theo giá B1.
      totalCost += 50 * A1 + (usage1 - 50) * B1;
    } else {
      // Nếu mức tiêu thụ lớn hơn 150 kWh:
      // - Tính chi phí cho 50 kWh đầu tiên theo giá A1.
      // - Tính chi phí cho 100 kWh tiếp theo (từ 51 đến 150) theo giá B1.
      // - Tính chi phí cho phần mức tiêu thụ vượt quá 150 kWh (trên 150) theo giá C1.
      totalCost += 50 * A1 + 100 * B1 + (usage1 - 150) * C1;
    }

// Tính chi phí cho công nghiệp (loại 2)
    if (usage2 <= 200) {
      // Nếu mức tiêu thụ nhỏ hơn hoặc bằng 200 kWh, chi phí tính bằng giá A2 cho mỗi kWh.
      totalCost += usage2 * A2;
    } else if (usage2 <= 1000) {
      // Nếu mức tiêu thụ lớn hơn 200 kWh và nhỏ hơn hoặc bằng 1000 kWh:
      // - Tính chi phí cho 200 kWh đầu tiên theo giá A2.
      // - Tính chi phí cho phần mức tiêu thụ vượt quá 200 kWh (từ 201 đến 1000) theo giá B2.
      totalCost += 200 * A2 + (usage2 - 200) * B2;
    } else {
      // Nếu mức tiêu thụ lớn hơn 1000 kWh:
      // - Tính chi phí cho 200 kWh đầu tiên theo giá A2.
      // - Tính chi phí cho 800 kWh tiếp theo (từ 201 đến 1000) theo giá B2.
      // - Tính chi phí cho phần mức tiêu thụ vượt quá 1000 kWh (trên 1000) theo giá C2.
      totalCost += 200 * A2 + 800 * B2 + (usage2 - 1000) * C2;
    }

// Tính chi phí cho doanh nghiệp (loại 3)
    if (usage3 <= 100) {
      // Nếu mức tiêu thụ nhỏ hơn hoặc bằng 100 kWh, chi phí tính bằng giá A3 cho mỗi kWh.
      totalCost += usage3 * A3;
    } else if (usage3 <= 200) {
      // Nếu mức tiêu thụ lớn hơn 100 kWh và nhỏ hơn hoặc bằng 200 kWh:
      // - Tính chi phí cho 100 kWh đầu tiên theo giá A3.
      // - Tính chi phí cho phần mức tiêu thụ vượt quá 100 kWh (từ 101 đến 200) theo giá B3.
      totalCost += 100 * A3 + (usage3 - 100) * B3;
    } else {
      // Nếu mức tiêu thụ lớn hơn 200 kWh:
      // - Tính chi phí cho 100 kWh đầu tiên theo giá A3.
      // - Tính chi phí cho 100 kWh tiếp theo (từ 101 đến 200) theo giá B3.
      // - Tính chi phí cho phần mức tiêu thụ vượt quá 200 kWh (trên 200) theo giá C3.
      totalCost += 100 * A3 + 100 * B3 + (usage3 - 200) * C3;
    }

    // Hiển thị kết quả qua dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text('Số phòng tối thiểu cần dùng: ${totalCost + 9}',
              style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20)), // Nội dung của dialog
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('OK'), // Nút OK để đóng dialog
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tạo danh sách các controller và nhãn
    final List<Map<String, dynamic>> controllers = [
      {'label': 'X1', 'controller': x1Controller},
      {'label': 'Y1', 'controller': y1Controller},
      {'label': 'X2', 'controller': x2Controller},
      {'label': 'Y2', 'controller': y2Controller},
      {'label': 'X3', 'controller': x3Controller},
      {'label': 'Y3', 'controller': y3Controller},
      {'label': 'A1', 'controller': a1Controller},
      {'label': 'B1', 'controller': b1Controller},
      {'label': 'C1', 'controller': c1Controller},
      {'label': 'A2', 'controller': a2Controller},
      {'label': 'B2', 'controller': b2Controller},
      {'label': 'C2', 'controller': c2Controller},
      {'label': 'A3', 'controller': a3Controller},
      {'label': 'B3', 'controller': b3Controller},
      {'label': 'C3', 'controller': c3Controller},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('BaiTap08'),
        backgroundColor: Colors.blueAccent, // Màu nền của AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sử dụng vòng lặp for để tạo các TextField
            for (var field in controllers)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: field['controller']!,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: field['label'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bo góc viền
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    filled: true,
                    fillColor: Colors.grey[200], // Màu nền của ô nhập
                  ),
                  style:
                      const TextStyle(fontSize: 16.0), // Kích thước phông chữ
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: calculateCost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Màu nền của nút
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bo góc nút
                  ),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 18.0), // Kích thước phông chữ
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
