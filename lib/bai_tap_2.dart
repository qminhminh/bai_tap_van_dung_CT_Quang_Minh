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
  int countEvenDivisibleBy3(int n) {
    if (n < 6) return 0; // Nếu n nhỏ hơn 6 thì không có số chẵn chia hết cho 3
    return n ~/ 6; // Chia n cho 6 để tìm số lượng số chẵn chia hết cho 3
  }

  // Hàm tính tổng các số chẵn chia hết cho 3 từ 1 đến n
  int sumEvenDivisibleBy3(int n) {
    if (n < 6) return 0; // Nếu n nhỏ hơn 6 thì không có số chẵn chia hết cho 3
    int count = countEvenDivisibleBy3(n);
    return 6 *
        count *
        (count + 1) ~/
        2; // Công thức tổng của các số chẵn chia hết cho 3
  }

  // Hàm xử lý tính toán và hiển thị kết quả
  void _calculate() {
    final int? a = int.tryParse(_aController.text);
    final int? b = int.tryParse(_bController.text);

    if (a == null || b == null || a > b) {
      // Hiển thị thông báo lỗi nếu a hoặc b không hợp lệ
      _showDialog('Vui lòng nhập các giá trị hợp lệ với a <= b.');
      return;
    }

    // Tính số lượng và tổng từ 1 đến b
    int countB = countEvenDivisibleBy3(b);
    int sumB = sumEvenDivisibleBy3(b);

    // Tính số lượng và tổng từ 1 đến a-1
    int countA = countEvenDivisibleBy3(a - 1);
    int sumA = sumEvenDivisibleBy3(a - 1);

    // Tính số lượng và tổng trong khoảng từ a đến b
    int count = countB - countA;
    int totalSum = sumB - sumA;

    if (totalSum + a + b > 0) {
      // Hiển thị kết quả nếu tổng lớn hơn 0
      _showDialog(
          'Số lượng số chẵn chia hết cho 3: $count\nTổng của chúng: $totalSum');
    } else {
      // Hiển thị thông báo nếu không có số chẵn nào chia hết cho 3
      _showDialog('Không có số chẵn nào chia hết cho 3 trong đoạn [a, b].');
    }
  }

  // Hàm hiển thị hộp thoại với thông báo kết quả
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết Quả'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn nút Đóng
              },
              child: const Text('Đóng'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextField để nhập giá trị a
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập giá trị a',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // TextField để nhập giá trị b
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập giá trị b',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Nút để thực hiện tính toán
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Tính Toán'),
            ),
          ],
        ),
      ),
    );
  }
}
