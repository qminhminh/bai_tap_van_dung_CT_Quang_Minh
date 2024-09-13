// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _inputController = TextEditingController();

  // Hàm mã hóa số theo quy tắc đã cho.
  String encode(String input) {
    String result = "";
    int count = 1;

    for (int i = 1; i < input.length; i++) {
      if (input[i] == input[i - 1]) {
        count++;
      } else {
        result += count.toString() + input[i - 1];
        count = 1;
      }
    }
    result +=
        count.toString() + input[input.length - 1]; // Xử lý phần cuối chuỗi
    return result;
  }

  // Hàm giải mã từ chuỗi mã hóa về chuỗi trước đó (giải nén N về M)
  String decode(String input) {
    String result = "";
    int i = 0;

    while (i < input.length) {
      int count = int.parse(input[i]); // Lấy số lượng xuất hiện của ký tự
      String digit = input[i + 1]; // Ký tự cần lặp lại
      result += digit * count; // Thêm ký tự vào kết quả dựa trên số lần lặp lại
      i += 2; // Chuyển đến cặp tiếp theo
    }
    return result;
  }

  // Hàm kiểm tra xem một số M có hợp lệ hay không
  bool isValidM(String M) {
    // Kiểm tra số lượng ký tự liên tiếp không vượt quá 9
    RegExp pattern = RegExp(r'(.)\1{9,}');
    return !pattern.hasMatch(M);
  }

  // Hàm tìm M từ N
  String findM(String N) {
    // Bắt đầu từ số N và giải mã liên tục để tìm số M
    String current = N;
    Set<String> visited = Set(); // Để theo dõi các chuỗi đã xử lý

    while (true) {
      String decoded = decode(current);

      // Nếu mã hóa của chuỗi giải mã lại chính là N và chuỗi giải mã hợp lệ, đó là số M
      if (encode(decoded) == N && isValidM(decoded)) {
        return decoded;
      }

      // Nếu chuỗi đã giải mã không thay đổi hoặc đã xử lý rồi thì không tìm thấy
      if (visited.contains(decoded) || decoded == current) {
        return "Không tìm thấy M";
      }

      visited.add(current); // Đánh dấu chuỗi hiện tại đã xử lý
      current = decoded; // Tiếp tục với chuỗi giải mã
    }
  }

  // Hàm hiển thị kết quả qua popup.
  void _showResult(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Kết quả"),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
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
        title: const Text("Tìm Số M"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: "Nhập số N",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // Chỉ nhập số
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String N =
                    _inputController.text; // Lấy giá trị nhập từ TextField
                if (N.isNotEmpty) {
                  String M = findM(N); // Tìm số M
                  _showResult(
                      context, "Số M là: $M"); // Hiển thị kết quả qua popup
                } else {
                  _showResult(context, "Dữ liệu nhập không hợp lệ.");
                }
              },
              child: const Text("Tìm số M"),
            ),
          ],
        ),
      ),
    );
  }
}
