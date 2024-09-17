// ignore_for_file: curly_braces_in_flow_control_structures, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';

class BaiTap06 extends StatefulWidget {
  const BaiTap06({super.key});

  @override
  State<BaiTap06> createState() => _BaiTap06State();
}

class _BaiTap06State extends State<BaiTap06> {
  // Controller để nhận dữ liệu từ người dùng nhập vào hai số A và B
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();

  // Danh sách để lưu các biển số xe đẹp tìm được
  List<int> beautifulNumbers = [];

  // Hàm kiểm tra một số có phải là số nguyên tố hay không
  bool _isPrime(int n) {
    if (n < 2) return false; // Số nhỏ hơn 2 không phải là số nguyên tố
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0)
        return false; // Nếu tìm thấy số chia hết, không phải số nguyên tố
    }
    return true; // Nếu không tìm thấy số nào chia hết, đây là số nguyên tố
  }

  // Hàm kiểm tra một số có phải là số đối xứng (Palindrome) hay không
  bool _isPalindrome(int n) {
    String str = n.toString(); // Chuyển số thành chuỗi
    String reversedStr = str.split('').reversed.join(''); // Đảo ngược chuỗi
    return str == reversedStr; // So sánh chuỗi ban đầu với chuỗi đảo ngược
  }

  // Hàm tìm biển số xe đẹp (vừa là số nguyên tố, vừa là số đối xứng)
  void findBeautifulLicensePlates() {
    int a = int.tryParse(_aController.text) ??
        0; // Lấy giá trị A từ ô nhập, mặc định 0 nếu không hợp lệ
    int b = int.tryParse(_bController.text) ??
        0; // Lấy giá trị B từ ô nhập, mặc định 0 nếu không hợp lệ

    beautifulNumbers.clear(); // Xóa danh sách cũ (nếu có)

    // Duyệt qua tất cả các số từ A đến B
    for (int i = a; i <= b; i++) {
      if (_isPrime(i) && _isPalindrome(i)) {
        beautifulNumbers.add(
            i); // Nếu số i vừa là số nguyên tố, vừa là số đối xứng thì thêm vào danh sách
      }
    }

    // Hiển thị kết quả trong một popup
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kết quả',
            style: TextStyle(
                color: Colors.blueAccent, fontSize: 30)), // Tiêu đề popup
        content: Text(
            'Số lượng biển số xe đẹp: ${beautifulNumbers.length}\nBiển số xe đẹp: ${beautifulNumbers.join(', ')}',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 20)),
        // Nội dung popup gồm số lượng và danh sách biển số xe đẹp
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng popup khi nhấn OK
            },
            child: const Text('OK'), // Nút OK
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text(message,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm biển số đẹp'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField để nhập giá trị A
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nhập số A',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.numbers),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // TextField để nhập giá trị B
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nhập số B',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.numbers),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Nút bấm để bắt đầu tìm kiếm biển số đẹp
            ElevatedButton(
              onPressed: findBeautifulLicensePlates,
              child: const Text('Tìm biển số đẹp'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
