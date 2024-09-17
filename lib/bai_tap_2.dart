import 'package:flutter/material.dart';

class BaiTap02 extends StatefulWidget {
  const BaiTap02({super.key});

  @override
  State<BaiTap02> createState() => _BaiTap02State();
}

class _BaiTap02State extends State<BaiTap02> {
  final _formKey = GlobalKey<FormState>();

  // Controllers để nhận giá trị từ các TextField
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();

  // Hàm tính số lượng số chẵn chia hết cho 3 từ 1 đến n
  int countEvenDivisible(int n) {
    if (n < 6) return 0;
    return n ~/ 6;
  }

  // Hàm tính tổng các số chẵn chia hết cho 3 từ 1 đến n
  int sumEvenDivisibleBy3(int n) {
    if (n < 6) return 0;
    int count = countEvenDivisible(n);
    return 6 * count * (count + 1) ~/ 2;
  }

  // Hàm xử lý tính toán và hiển thị kết quả
  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final int a = int.parse(_aController.text);
      final int b = int.parse(_bController.text);

      int countB = countEvenDivisible(b);
      int sumB = sumEvenDivisibleBy3(b);

      int countA = countEvenDivisible(a - 1);
      int sumA = sumEvenDivisibleBy3(a - 1);

      int count = countB - countA;
      int totalSum = sumB - sumA;

      if (totalSum > 0) {
        _showResultDialog(
            'Số lượng số chẵn chia hết cho 3: $count\nTổng của chúng: $totalSum');
      } else {
        _showResultDialog(
            'Không có số chẵn nào chia hết cho 3 trong đoạn [a, b].');
      }
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
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 30),
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
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background container
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Hình thức các yếu tố trên đầu nền
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _aController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nhập giá trị a',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập giá trị a';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Giá trị a phải là số nguyên hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nhập giá trị b',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập giá trị b';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Giá trị b phải là số nguyên hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      clipBehavior: Clip.antiAlias,
                      focusNode: FocusNode(),
                      autofocus: false,
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Tính Toán',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
