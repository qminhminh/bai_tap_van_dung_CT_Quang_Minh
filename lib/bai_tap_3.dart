// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps, avoid_print, prefer_if_null_operators

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaiTap03 extends StatefulWidget {
  const BaiTap03({super.key});

  @override
  State<BaiTap03> createState() => _BaiTap03State();
}

class _BaiTap03State extends State<BaiTap03> {
  final TextEditingController _numbersController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BigInt? factorial;
  bool _isProcessing = false;
  String? factorialResult;

  // Phương thức để xử lý dãy số nhập vào.
  void _processNumbers() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isProcessing = true;
      });

      // Lấy chuỗi đầu vào từ TextField và chuyển thành danh sách số nguyên.
      final input = _numbersController.text;
      final numbers =
          input.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
      if (numbers.any((number) => number < 0)) {
        _showErrorDialog("số phải lớn hơn 0");
      } else {
        // Kiểm tra nếu danh sách số trống hoặc có số nhỏ hơn 0.
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

        // Tính giai thừa của số lớn thứ hai, kiểm tra giá trị số lớn
        //  String factorial;
        if (secondLargest < 30000) {
          factorial = await compute(_factorial, BigInt.from(secondLargest));

          // Dùng BigInt cho số không quá lớn
        } else {
          factorialResult = _stirlingApproximation(secondLargest)
              .toStringAsFixed(10); // Xấp xỉ Stirling
          // factorial = _stirlingApproximation(secondLargest)
          //     .toStringAsFixed(10); // Dùng phép xấp xỉ Stirling
        }

        // Tính số Fibonacci thứ X (X là số lớn thứ hai).
        final fibonacci = _fibonacciMatrix(secondLargest);
        setState(() {
          _isProcessing = false; // Kết thúc trạng thái xử lý
        });
        print("giai thua: +${factorial} +${factorialResult}");
        // Hiển thị kết quả trong hộp thoại.
        _showResult(
          'Số lớn thứ hai: $secondLargest\n' // Số lớn thứ hai.
          'Chẵn/Lẻ: ${isEven ? "Yes" : "No"}\n' // Kiểm tra chẵn/lẻ.
          'Nguyên tố: ${isPrime ? "Yes" : "No"}\n' // Kiểm tra số nguyên tố.
          'Giai thừa: ${factorial == null ? factorialResult : factorial}\n' // Giai thừa của số lớn thứ hai (hoặc phép xấp xỉ Stirling).
          'Fibonacci: $fibonacci', // Số Fibonacci thứ X.
        );
      }
    }
  }

  String _factorialToScientific(BigInt factorial) {
    int trailingZeros = _countTrailingZeros(factorial);
    BigInt powerOfTen = BigInt.from(10).pow(trailingZeros);
    BigInt resultWithoutTrailingZeros = factorial ~/ powerOfTen;

    return '${resultWithoutTrailingZeros}e+$trailingZeros';
  }

  int _countTrailingZeros(BigInt factorial) {
    int count = 0;
    BigInt number = BigInt.from(5);
    while (number <= factorial) {
      count += (factorial ~/ number).toInt();
      number *= BigInt.from(5);
    }
    return count;
  }

  // Chức năng hiển thị lỗi trong hộp thoại
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

  // Phương thức tính giai thừa theo xấp xỉ Stirling cho số lớn.
  double _stirlingApproximation(int n) {
    double pi = 3.1415926535897932;
    double e = 2.718281828459045;
    return sqrt(2 * pi * n) * pow(n / e, n);
  }

  // Phương thức tính số Fibonacci thứ X sử dụng thuật toán ma trận.
  BigInt _fibonacciMatrix(int n) {
    if (n < 0) return BigInt.zero;
    if (n == 0) return BigInt.zero;
    if (n == 1) return BigInt.one;

    // Ma trận cơ sở [[1, 1], [1, 0]]
    List<List<BigInt>> F = [
      [BigInt.one, BigInt.one],
      [BigInt.one, BigInt.zero]
    ];

    // Nâng ma trận cơ sở lên lũy thừa (n - 1)
    _matrixPower(F, n - 1);

    // Kết quả Fibonacci là F[0][0] sau khi tính xong
    return F[0][0];
  }

  void _matrixPower(List<List<BigInt>> F, int n) {
    if (n <= 1) return;

    // Ma trận cơ sở để nhân
    List<List<BigInt>> M = [
      [BigInt.one, BigInt.one],
      [BigInt.one, BigInt.zero]
    ];

    _matrixPower(F, n ~/ 2); // Đệ quy tính lũy thừa ma trận
    _multiplyMatrices(F, F); // Nhân ma trận F với chính nó

    if (n % 2 != 0) {
      _multiplyMatrices(F, M); // Nhân thêm ma trận cơ sở nếu n lẻ
    }
  }

  void _multiplyMatrices(List<List<BigInt>> F, List<List<BigInt>> M) {
    // Tính toán nhân hai ma trận 2x2
    BigInt x = F[0][0] * M[0][0] + F[0][1] * M[1][0];
    BigInt y = F[0][0] * M[0][1] + F[0][1] * M[1][1];
    BigInt z = F[1][0] * M[0][0] + F[1][1] * M[1][0];
    BigInt w = F[1][0] * M[0][1] + F[1][1] * M[1][1];

    F[0][0] = x;
    F[0][1] = y;
    F[1][0] = z;
    F[1][1] = w;
  }

  // Phương thức để hiển thị kết quả trong hộp thoại.
  void _showResult(String result) {
    showDialog(
      context: context, // Context của ứng dụng để hiển thị hộp thoại.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30)), // Tiêu đề của hộp thoại.
          content: SingleChildScrollView(
            // Thêm cuộn nếu nội dung quá dài.
            child: Text(result, style: const TextStyle(fontSize: 20)),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn OK.
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
                onPressed: _isProcessing ? null : _processNumbers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Màu nền của nút.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bo góc nút.
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0), // Padding cho nút.
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Tìm và xử lý số lớn thứ hai',
                        style:
                            TextStyle(fontSize: 16), // Kích thước chữ trên nút.
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BigInt _factorial(BigInt num) {
  BigInt result = BigInt.one;
  for (BigInt i = BigInt.from(2); i <= num; i = i + BigInt.one) {
    result *= i;
  }
  return result;
}
