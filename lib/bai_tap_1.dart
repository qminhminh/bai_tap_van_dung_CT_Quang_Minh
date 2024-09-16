// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_is_empty

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _numberController = TextEditingController();

  // Hàm giải mã chuỗi, tìm lại M từ N
  String decode(String encoded) {
    // Giữ chuỗi hiện tại là chuỗi kết quả ban đầu
    String current = encoded;

    while (true) {
      String next = '';
      int i = 0;

      // Thực hiện việc giải mã theo dạng: "2" -> số lần lặp, "1" -> số xuất hiện
      while (i < current.length) {
        int repeatCount = int.parse(current[i]); // Số lần lặp của số
        String digit = current[i + 1]; // Số cần lặp
        next += digit * repeatCount; // Thêm vào kết quả số được lặp nhiều lần
        i += 2; // Tăng i để bỏ qua số đã được xử lý
      }

      // Kiểm tra điều kiện dừng: Nếu chiều dài chuỗi giải mã <= 3, chuỗi đã quay về trạng thái ban đầu
      if (next.length <= 3) {
        return next; // Đây là số M ban đầu
      }

      current = next; // Cập nhật chuỗi cho lần lặp tiếp theo
    }
  }

  // Function to show result in a dialog
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Số gốc m'),
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
    final String input = _numberController.text;

    if (input.isEmpty) {
      _showErrorDialog('Vui lòng nhập một số được mã hóa.');
      return;
    }

    try {
      final String result = decode(input);
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
        backgroundColor: Colors.blueAccent, // Thay đổi màu nền của AppBar
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
                border:
                    OutlineInputBorder(), // Thay đổi kiểu viền của TextField
                labelText: 'Số được mã hóa',
                prefixIcon: Icon(
                    Icons.lock), // Thêm biểu tượng vào bên trái của TextField
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10), // Thay đổi padding nội dung
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _decodeInput,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent, // Màu văn bản của nút
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0), // Khoảng cách bên trong nút
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Bo tròn các góc của nút
                ),
                elevation: 5, // Độ cao bóng đổ của nút
              ),
              child: const Text(
                'Giải mã',
                style: TextStyle(
                  fontSize: 18, // Kích thước chữ
                  fontWeight: FontWeight.bold, // Độ đậm của chữ
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
