import 'package:flutter/material.dart';

class BaiTap02 extends StatefulWidget {
  const BaiTap02({super.key});

  @override
  State<BaiTap02> createState() => _BaiTap02State();
}

class _BaiTap02State extends State<BaiTap02> {
  // Controllers để nhận giá trị từ các TextField
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();

  // Hàm tính số lượng số chẵn chia hết cho 3 từ 1 đến n
  int countEvenDivisible(int n) {
    if (n < 6) return 0; // Nếu n nhỏ hơn 6 thì không có số chẵn chia hết cho 3
    return n ~/ 6; // Chia n cho 6 để tìm số lượng số chẵn chia hết cho 3
  }

  // Hàm tính tổng các số chẵn chia hết cho 3 từ 1 đến n
  int sumEvenDivisibleBy3(int n) {
    if (n < 6) return 0; // Nếu n nhỏ hơn 6 thì không có số chẵn chia hết cho 3
    int count = countEvenDivisible(n);
    return 6 *
        count *
        (count + 1) ~/
        2; // Công thức tổng của các số chẵn chia hết cho 3
  }

  // Hàm xử lý tính toán và hiển thị kết quả
  void _calculate() {
    final int? a = int.tryParse(_aController.text);
    final int? b = int.tryParse(_bController.text);

    if (a == null || b == null) {
      // Hiển thị thông báo lỗi nếu a hoặc b không hợp lệ
      _showResultDialog('Vui lòng nhập các giá trị hợp lệ.');
      return;
    }

    // Tính số lượng và tổng từ 1 đến b
    int countB = countEvenDivisible(b);
    int sumB = sumEvenDivisibleBy3(b);

    // Tính số lượng và tổng từ 1 đến a-1
    int countA = countEvenDivisible(a - 1);
    int sumA = sumEvenDivisibleBy3(a - 1);

    // Tính số lượng và tổng trong khoảng từ a đến b
    int count = countB - countA;
    int totalSum = sumB - sumA;

    if (totalSum + a + b > 0) {
      // Hiển thị kết quả nếu tổng lớn hơn 0
      _showResultDialog(
          'Số lượng số chẵn chia hết cho 3: $count\nTổng của chúng: $totalSum');
    } else {
      // Hiển thị thông báo nếu không có số chẵn nào chia hết cho 3
      _showResultDialog(
          'Không có số chẵn nào chia hết cho 3 trong đoạn [a, b].');
    }
  }

  // Hàm hiển thị hộp thoại với thông báo kết quả
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text(
            result,
            style: TextStyle(
                fontFamily: FontWeight.bold.toString(),
                color: Colors.blue,
                fontSize: 30),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 20),
              ),
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
        title: const Text('Số Chẵn Chia Hết Cho 3'),
        backgroundColor: Colors.blueAccent, // Thay đổi màu nền của AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập giá trị a',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons
                    .numbers), // Thêm biểu tượng vào bên trái của TextField
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10), // Thay đổi padding nội dung
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập giá trị b',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons
                    .numbers), // Thêm biểu tượng vào bên trái của TextField
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10), // Thay đổi padding nội dung
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
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
                'Tính Toán',
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
