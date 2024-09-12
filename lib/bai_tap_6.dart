// ignore_for_file: curly_braces_in_flow_control_structures

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
        title: const Text('Kết quả'), // Tiêu đề popup
        content: Text(
            'Số lượng biển số xe đẹp: ${beautifulNumbers.length}\nBiển số xe đẹp: ${beautifulNumbers.join(', ')}'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm biển số đẹp'), // Tiêu đề trên thanh AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding cho giao diện chính
        child: Column(
          children: [
            // TextField để nhập giá trị A
            TextField(
              controller:
                  _aController, // Liên kết với controller để lấy giá trị A
              keyboardType: TextInputType.number, // Chỉ cho phép nhập số
              decoration: const InputDecoration(
                labelText: 'Nhập số A', // Nhãn cho ô nhập
              ),
            ),
            // TextField để nhập giá trị B
            TextField(
              controller:
                  _bController, // Liên kết với controller để lấy giá trị B
              keyboardType: TextInputType.number, // Chỉ cho phép nhập số
              decoration: const InputDecoration(
                labelText: 'Nhập số B', // Nhãn cho ô nhập
              ),
            ),
            const SizedBox(height: 20), // Khoảng cách giữa các ô nhập và nút
            // Nút bấm để bắt đầu tìm kiếm biển số đẹp
            ElevatedButton(
              onPressed:
                  findBeautifulLicensePlates, // Gọi hàm tìm biển số đẹp khi nhấn nút
              child: const Text('Tìm biển số đẹp'), // Nội dung nút
            ),
          ],
        ),
      ),
    );
  }
}
