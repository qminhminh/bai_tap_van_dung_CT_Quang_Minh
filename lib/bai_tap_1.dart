// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _inputController = TextEditingController();

  // Hàm mã hóa số theo nguyên tắc đã cho
  String encodeNumber(String input) {
    String result = ""; // Chuỗi kết quả mã hóa
    int count = 1; // Biến đếm số lần xuất hiện liên tiếp của cùng một chữ số

    // Duyệt qua từng ký tự trong chuỗi đầu vào, bắt đầu từ vị trí thứ 1
    for (int i = 1; i < input.length; i++) {
      if (input[i] == input[i - 1]) {
        // Nếu ký tự hiện tại giống với ký tự trước đó
        count++; // Tăng biến đếm
      } else {
        // Nếu ký tự hiện tại khác ký tự trước đó
        result += count.toString() +
            input[i - 1]; // Thêm số lần xuất hiện và ký tự trước vào kết quả
        count = 1; // Đặt lại biến đếm cho chuỗi tiếp theo
      }
    }

    // Thêm ký tự cuối cùng và số lần xuất hiện của nó vào kết quả
    result += count.toString() + input[input.length - 1];
    return result; // Trả về chuỗi đã được mã hóa
  }

  // Hàm tìm số M từ N, không giới hạn số lần lặp
  String findMtoN(String N) {
    String current = "1"; // Bắt đầu từ số nhỏ nhất có thể, "1"

    // Lặp vô hạn để tiếp tục tìm kiếm số M
    while (true) {
      String nextEncode =
          encodeNumber(current); // Mã hóa giá trị hiện tại của chuỗi `current`

      // Kiểm tra nếu mã hóa của `current` trùng với N, trả về số M hiện tại
      if (nextEncode == N) {
        return current;
      }
      // Nếu độ dài của chuỗi mã hóa lớn hơn N, không thể tìm thấy, thoát khỏi vòng lặp
      else if (nextEncode.length > N.length) {
        return "Không tìm thấy M"; // Trả về thông báo khi không tìm được số M
      }

      // Nếu chưa tìm thấy, cập nhật `current` bằng kết quả mã hóa mới và tiếp tục lặp
      current = nextEncode;
    }
  }

  // Hàm hiển thị kết quả qua popup (hộp thoại)
  void _showResult(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Kết quả"), // Tiêu đề hộp thoại
          content: Text(result), // Nội dung hiển thị kết quả tìm được
          actions: <Widget>[
            TextButton(
              child: const Text("OK"), // Nút bấm OK để đóng hộp thoại
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn OK
              },
            ),
          ],
        );
      },
    );
  }

  // Hàm xây dựng giao diện của ứng dụng
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mã Hóa Số"), // Tiêu đề của AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Căn lề toàn màn hình
        child: Column(
          children: <Widget>[
            // Ô nhập liệu cho người dùng nhập số N
            TextField(
              controller:
                  _inputController, // Kết nối với bộ điều khiển để lấy dữ liệu nhập
              decoration: const InputDecoration(
                labelText: "Nhập số N", // Nhãn cho ô nhập liệu
                border: OutlineInputBorder(), // Đường viền cho ô nhập
              ),
              keyboardType: TextInputType.number, // Chỉ cho phép nhập ký tự số
            ),
            const SizedBox(height: 20), // Khoảng cách giữa ô nhập và nút bấm
            // Nút bấm để thực hiện tìm số M
            ElevatedButton(
              onPressed: () {
                String N = _inputController
                    .text; // Lấy giá trị nhập vào từ ô TextField
                if (N.isNotEmpty) {
                  String M = findMtoN(N); // Gọi hàm tìm số M
                  _showResult(
                      context, "Số M là: $M"); // Hiển thị kết quả qua popup
                } else {
                  _showResult(context,
                      "Dữ liệu nhập không hợp lệ."); // Thông báo nếu nhập liệu không hợp lệ
                }
              },
              child: const Text("Tìm số M"), // Nội dung nút bấm
            ),
          ],
        ),
      ),
    );
  }
}
