import 'package:flutter/material.dart';

class BaiTap07 extends StatefulWidget {
  const BaiTap07({super.key});

  @override
  State<BaiTap07> createState() => _BaiTap07State();
}

class _BaiTap07State extends State<BaiTap07> {
  final TextEditingController _controller = TextEditingController();
  List<int> divisible = []; // Danh sách chứa các số chia hết cho 3
  int countDivisible = 0; // Đếm số lượng các số chia hết cho 3

  // Hàm kiểm tra xem một số có chia hết cho 3 hay không
  bool _isDivisible(int number) {
    return number % 3 == 0;
  }

  // Hàm tạo các số mới từ số n bằng cách xóa các chữ số liên tiếp
  Set<int> generateNumbers(int number) {
    String numtoStr = number.toString();
    Set<int> resultSet = {number}; // Khởi tạo tập với số ban đầu

    // Lặp qua tất cả các phần tử từ n
    for (int i = 0; i < numtoStr.length; i++) {
      for (int j = i + 1; j <= numtoStr.length; j++) {
        // Lấy một phần của chuỗi nStr và loại bỏ các số 0 ở đầu
        String sub = numtoStr.substring(i, j).replaceFirst(RegExp(r'^0+'), '');

        // Nếu chuỗi con không rỗng, thêm số đó vào tập kết quả
        if (sub.isNotEmpty) {
          resultSet.add(int.parse(sub));
        }
      }
    }

    return resultSet;
  }

  // Hàm xử lý khi người dùng nhấn nút "Tính toán"
  void calculateDivisibleBy3() {
    setState(() {
      divisible.clear(); // Xóa danh sách cũ
      countDivisible = 0; // Đặt lại số lượng

      int number = int.parse(_controller.text); // Lấy số n từ người dùng
      Set<int> numberSet = generateNumbers(number); // Sinh các số từ n

      // Lặp qua tất cả các số trong tập D
      for (int numbers in numberSet) {
        // Nếu số đó chia hết cho 3, thêm vào danh sách và tăng số lượng
        if (_isDivisible(numbers)) {
          divisible.add(numbers);
          countDivisible++;
        }
      }

      // Hiển thị kết quả bằng popup
      _showDialog(divisible, countDivisible);
    });
  }

  // Hàm hiển thị popup kết quả
  void _showDialog(List<int> divisibleBy3, int count) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Kết quả"),
          content: Text(
              "Các số chia hết cho 3 là: ${divisibleBy3.join(", ")}\nTổng số: $count"),
          actions: [
            TextButton(
              child: const Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
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
        title: const Text('Bài Tập 07'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number, // Bàn phím số
              decoration: const InputDecoration(
                labelText: "Nhập số nguyên n",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateDivisibleBy3, // Nút để tính toán
              child: const Text("Tính toán"),
            ),
          ],
        ),
      ),
    );
  }
}
