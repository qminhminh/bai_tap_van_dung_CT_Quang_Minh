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

  // Hàm tạo các số mới từ số n bằng cách xóa các chữ số liên tiếp
  Set<int> generateNumbers(int number) {
    String numtoStr = number.toString();
    Set<int> resultSet = {number}; // Khởi tạo tập với số ban đầu

    // Lặp qua tất cả các phần tử từ n
    for (int i = 0; i < numtoStr.length; i++) {
      for (int j = i + 1; j <= numtoStr.length; j++) {
        // Lấy một phần của chuỗi nStr và loại bỏ các số 0 ở đầu
        String sub = numtoStr.substring(0, i) + numtoStr.substring(j);

        // Nếu chuỗi con không rỗng, thêm số đó vào tập kết quả
        if (sub.isNotEmpty) {
          int num = int.parse(sub);
          // Loại bỏ các số có chữ số bắt đầu bằng 0
          if (sub.length == numtoStr.length - 1 || sub[0] != '0') {
            resultSet.add(num);
          }
        }
      }
    }

    return resultSet;
  }

  // Hàm tính các số chia hết cho 3
  void calculateDivisible() {
    setState(() {
      divisible.clear(); // Xóa danh sách cũ
      countDivisible = 0; // Đặt lại số lượng

      int number = int.parse(_controller.text); // Lấy số n từ người dùng
      Set<int> numberSet = generateNumbers(number); // Sinh các số từ n

      // Lặp qua tất cả các số trong tập D
      for (int num in numberSet) {
        if (num % 3 == 0) {
          // Nếu số đó chia hết cho 3
          divisible.add(num);
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
          title: const Text("Kết quả",
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text(
              "Các số chia hết cho 3 là: ${divisibleBy3.join(", ")}\nTổng số: $count",
              style: const TextStyle(color: Colors.blueAccent, fontSize: 20)),
          actions: [
            TextButton(
              child: const Text(
                "Đóng",
              ),
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
        title: const Text('Tính số chia hết cho 3'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number, // Bàn phím số
              decoration: const InputDecoration(
                labelText: "Nhập số nguyên n",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                prefixIcon: Icon(Icons.input, color: Colors.teal),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateDivisible, // Nút để tính toán
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal, // Màu chữ của nút
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bo góc nút
                ),
              ),
              child: const Text(
                "Tính toán",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
