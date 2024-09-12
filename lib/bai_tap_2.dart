import 'package:flutter/material.dart';

class BaiTap02 extends StatefulWidget {
  const BaiTap02({super.key});

  @override
  State<BaiTap02> createState() => _BaiTap02State();
}

class _BaiTap02State extends State<BaiTap02> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();

  // Phương thức để tính toán số lượng và tổng các số chẵn chia hết cho 3 trong đoạn [a, b].
  void _calculate() {
    // Lấy giá trị từ các TextEditingController và chuyển đổi thành số nguyên.
    final int a = int.tryParse(_aController.text) ?? 0;
    final int b = int.tryParse(_bController.text) ?? 0;

    // Kiểm tra nếu a lớn hơn b, hiển thị thông báo lỗi.
    if (a > b) {
      _showResult('Phạm vi không hợp lệ.Đảm bảo rằng A <= b.');
      return;
    }

    // Khởi tạo biến để đếm số lượng và tính tổng.
    int count = 0;
    int sum = 0;

    // Duyệt qua các số trong đoạn [a, b].
    for (int i = a; i <= b; i++) {
      // Kiểm tra xem số hiện tại có phải là số chẵn chia hết cho 3 không.
      if (i % 2 == 0 && i % 3 == 0) {
        count++; // Tăng số lượng số chẵn chia hết cho 3.
        sum += i; // Cộng số hiện tại vào tổng.
      }
    }

    // Hiển thị kết quả trong một hộp thoại.
    _showResult('Đếm: $count\nTổng: $sum');
  }

  // Phương thức để hiển thị kết quả trong hộp thoại.
  void _showResult(String result) {
    showDialog(
      context: context, // Context của ứng dụng để hiển thị hộp thoại.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả'), // Tiêu đề của hộp thoại.
          content:
              Text(result), // Nội dung của hộp thoại, chứa kết quả tính toán.
          actions: [
            // Các hành động (nút) trong hộp thoại.
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn nút OK.
              },
              child: const Text('Kết quả'),
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
        title: const Text('Đếm số lượng các số chắn chia hết cho 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số a:',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số b:',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Tính toán'),
            ),
          ],
        ),
      ),
    );
  }
}
