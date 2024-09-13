// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';
import 'package:flutter/material.dart';

class BaiTap03 extends StatefulWidget {
  const BaiTap03({super.key});

  @override
  State<BaiTap03> createState() => _BaiTap03State();
}

class _BaiTap03State extends State<BaiTap03> {
  final TextEditingController _numbersController = TextEditingController();

  // Phương thức để xử lý dãy số nhập vào.
  void _processNumbers() {
    // Lấy chuỗi đầu vào từ TextField và chuyển thành danh sách số nguyên.
    final input = _numbersController.text;
    final numbers =
        input.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();

    // Kiểm tra nếu danh sách số trống.
    if (numbers.isEmpty) {
      _showResult('No'); // Hiển thị "No" nếu không có số.
      return;
    }

    // Loại bỏ số trùng lặp, sắp xếp theo thứ tự giảm dần.
    final sortedNumbers = numbers.toSet().toList()
      ..sort((a, b) => b.compareTo(a));

    // Kiểm tra nếu không có đủ số để xác định số lớn thứ hai.
    if (sortedNumbers.length < 2) {
      _showResult('No'); // Hiển thị "No" nếu không có số lớn thứ hai.
      return;
    }

    // Lấy số lớn thứ hai từ danh sách đã sắp xếp.
    final secondLargest = sortedNumbers[1];

    // Kiểm tra xem số lớn thứ hai có phải là số chẵn hay lẻ.
    final isEven = secondLargest % 2 == 0;
    // Kiểm tra xem số lớn thứ hai có phải là số nguyên tố.
    final isPrime = _isPrime(secondLargest);
    // Tính giai thừa của số lớn thứ hai.
    final factorial = _factorial(secondLargest);
    // Tính số Fibonacci thứ X (X là số lớn thứ hai).
    final fibonacci = _fibonacci(secondLargest);

    // Hiển thị kết quả trong hộp thoại.
    _showResult(
      'Số lớn thứ hai: $secondLargest\n' // Số lớn thứ hai.
      'Chẵn/Lẻ: ${isEven ? "Yes" : "No"}\n' // Kiểm tra chẵn/lẻ.
      'Nguyên tố: ${isPrime ? "Yes" : "No"}\n' // Kiểm tra số nguyên tố.
      'Giai thừa: $factorial\n' // Giai thừa của số lớn thứ hai.
      'Fibonacci: $fibonacci', // Số Fibonacci thứ X.
    );
  }

  // Phương thức kiểm tra xem một số có phải là số nguyên tố không.
  bool _isPrime(int num) {
    if (num <= 1)
      return false; // Số nhỏ hơn hoặc bằng 1 không phải là số nguyên tố.
    if (num == 2) return true; // 2 là số nguyên tố.
    if (num % 2 == 0)
      return false; // Số chẵn lớn hơn 2 không phải là số nguyên tố.
    // Kiểm tra từ 3 đến căn bậc hai của số, chỉ kiểm tra các số lẻ.
    for (int i = 3; i <= sqrt(num).toInt(); i += 2) {
      if (num % i == 0)
        return false; // Nếu chia hết cho i thì không phải số nguyên tố.
    }
    return true; // Nếu không chia hết cho bất kỳ số nào thì là số nguyên tố.
  }

  // Phương thức tính giai thừa của một số sử dụng BigInt.
  BigInt _factorial(int num) {
    if (num < 0) return BigInt.zero; // Giai thừa không định nghĩa cho số âm.
    BigInt result = BigInt.one; // Bắt đầu với 1.

    // Tính giai thừa từ 1 đến num.
    for (int i = 1; i <= num; i++) {
      result *= BigInt.from(i);
    }

    return result; // Trả về giai thừa sử dụng BigInt.
  }

  // Phương thức tính số Fibonacci thứ X.
  int _fibonacci(int num) {
    if (num < 0) return 0; // Số Fibonacci không định nghĩa cho số âm.
    if (num == 0) return 0; // Số Fibonacci thứ 0 là 0.
    if (num == 1) return 1; // Số Fibonacci thứ 1 là 1.
    int a = 0, b = 1, c;
    for (int i = 2; i <= num; i++) {
      c = a + b; // Tính số Fibonacci tiếp theo.
      a = b; // Cập nhật giá trị của a.
      b = c; // Cập nhật giá trị của b.
    }
    return b; // Trả về số Fibonacci thứ X.
  }

  // Phương thức để hiển thị kết quả trong hộp thoại.
  void _showResult(String result) {
    showDialog(
      context: context, // Context của ứng dụng để hiển thị hộp thoại.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả'), // Tiêu đề của hộp thoại.
          content: SingleChildScrollView(
            // Thêm cuộn trang ở đây.
            child:
                Text(result), // Nội dung của hộp thoại chứa kết quả tính toán.
          ),
          actions: [
            // Các hành động (nút) trong hộp thoại.
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn nút OK.
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Xây dựng giao diện người dùng của widget.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm số lớn thứ hai'), // Tiêu đề trên thanh app bar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Khoảng cách xung quanh nội dung.
        child: Column(
          children: [
            // TextField cho phép người dùng nhập dãy số.
            TextField(
              controller:
                  _numbersController, // Controller để quản lý dữ liệu nhập vào.
              keyboardType: TextInputType.number, // Định dạng bàn phím số.
              decoration: const InputDecoration(
                labelText:
                    'Nhập các số được phân tách bằng dấu phẩy', // Nhãn cho trường nhập liệu.
                border: OutlineInputBorder(), // Viền cho trường nhập liệu.
              ),
            ),
            const SizedBox(
                height:
                    16), // Khoảng cách giữa các trường nhập liệu và nút bấm.
            // Nút bấm để thực hiện xử lý dãy số.
            ElevatedButton(
              onPressed:
                  _processNumbers, // Gọi phương thức _processNumbers khi nhấn nút.
              child: const Text('Kết quả'), // Văn bản trên nút bấm.
            ),
          ],
        ),
      ),
    );
  }
}
