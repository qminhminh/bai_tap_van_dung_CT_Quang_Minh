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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<int, BigInt> _factorialCache = {}; // Cache cho giai thừa

  // Phương thức để xử lý dãy số nhập vào.
  void _processNumbers() {
    if (_formKey.currentState?.validate() ?? false) {
      final input = _numbersController.text;
      final numbers =
          input.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
      if (numbers.any((number) => number < 0)) {
        _showErrorDialog("Số phải lớn hơn 0");
      } else {
        if (numbers.isEmpty) {
          _showResult('No');
          return;
        }

        final sortedNumbers = numbers.toSet().toList()
          ..sort((a, b) => b.compareTo(a));

        if (sortedNumbers.length < 2) {
          _showResult('No');
          return;
        }

        final secondLargest = sortedNumbers[1];
        final isEven = secondLargest % 2 == 0;
        final isPrime = _isPrime(secondLargest);

        String factorial;
        if (secondLargest < 10000) {
          factorial = _factorial(secondLargest).toString();
        } else {
          factorial = _stirlingApproximation(secondLargest).toStringAsFixed(10);
        }

        final fibonacci = _fibonacciMatrix(secondLargest);

        _showResult(
          'Số lớn thứ hai: $secondLargest\n'
          'Chẵn/Lẻ: ${isEven ? "Yes" : "No"}\n'
          'Nguyên tố: ${isPrime ? "Yes" : "No"}\n'
          'Giai thừa: $factorial\n'
          'Fibonacci: $fibonacci',
        );
      }
    }
  }

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

  bool _isPrime(int num) {
    if (num <= 1) return false;
    if (num == 2) return true;
    if (num % 2 == 0) return false;
    for (int i = 3; i <= sqrt(num).toInt(); i += 2) {
      if (num % i == 0) return false;
    }
    return true;
  }

  BigInt _factorial(int num) {
    if (num < 0) return BigInt.zero;
    if (_factorialCache.containsKey(num)) {
      return _factorialCache[num]!;
    }

    BigInt result = BigInt.one;
    for (int i = 1; i <= num; i++) {
      result *= BigInt.from(i);
    }

    _factorialCache[num] = result; // Caching result
    return result;
  }

  double _stirlingApproximation(int n) {
    double pi = 3.1415926535897932;
    double e = 2.718281828459045;
    return sqrt(2 * pi * n) * pow(n / e, n);
  }

  BigInt _fibonacciMatrix(int n) {
    if (n < 0) return BigInt.zero;
    if (n == 0) return BigInt.zero;
    if (n == 1) return BigInt.one;

    List<List<BigInt>> F = [
      [BigInt.one, BigInt.one],
      [BigInt.one, BigInt.zero]
    ];

    _matrixPower(F, n - 1);

    return F[0][0];
  }

  void _matrixPower(List<List<BigInt>> F, int n) {
    if (n <= 1) return;

    List<List<BigInt>> M = [
      [BigInt.one, BigInt.one],
      [BigInt.one, BigInt.zero]
    ];

    _matrixPower(F, n ~/ 2);
    _multiplyMatrices(F, F);

    if (n % 2 != 0) {
      _multiplyMatrices(F, M);
    }
  }

  void _multiplyMatrices(List<List<BigInt>> F, List<List<BigInt>> M) {
    BigInt x = F[0][0] * M[0][0] + F[0][1] * M[1][0];
    BigInt y = F[0][0] * M[0][1] + F[0][1] * M[1][1];
    BigInt z = F[1][0] * M[0][0] + F[1][1] * M[1][0];
    BigInt w = F[1][0] * M[0][1] + F[1][1] * M[1][1];

    F[0][0] = x;
    F[0][1] = y;
    F[1][0] = z;
    F[1][1] = w;
  }

  void _showResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: SingleChildScrollView(
            child: Text(result, style: const TextStyle(fontSize: 20)),
          ),
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

  @override
  Widget build(BuildContext context) {
    // Xây dựng giao diện người dùng của widget.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm số lớn thứ hai'),
        backgroundColor: Colors.teal, // Màu nền của app bar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Để các widget mở rộng hết chiều ngang.
            children: [
              Form(
                key: _formKey, // Key để xác thực form.
                child: TextFormField(
                  controller: _numbersController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nhập các số được phân tách bằng dấu phẩy',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bo góc viền.
                    ),
                    prefixIcon: const Icon(
                        Icons.numbers), // Biểu tượng cho trường nhập liệu.
                    filled: true, // Nền màu cho trường nhập liệu.
                    fillColor: const Color.fromARGB(
                        255, 104, 179, 197), // Màu nền cho trường nhập liệu.
                  ),
                  style: const TextStyle(
                    fontSize: 18, // Kích thước chữ trong TextField.
                    color: Color.fromARGB(
                        255, 12, 12, 12), // Màu chữ trong TextField.
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                autofocus: false,
                focusNode: FocusNode(),
                clipBehavior: Clip.antiAlias,
                onPressed: _processNumbers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Màu nền của nút.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bo góc nút.
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0), // Padding cho nút.
                ),
                child: const Text(
                  'Tìm và xử lý số lớn thứ hai',
                  style: TextStyle(fontSize: 16), // Kích thước chữ trên nút.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
