import 'package:flutter/material.dart';

class BaiTap02 extends StatefulWidget {
  const BaiTap02({super.key});

  @override
  State<BaiTap02> createState() => _BaiTap02State();
}

class _BaiTap02State extends State<BaiTap02>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Bộ điều khiển để nhận giá trị từ các TextField
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();

  // Animation controller và animation cho hiệu ứng xoay và mở rộng
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Thời gian cho cả hiệu ứng
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Khi animation hoàn thành, thu nhỏ về kích thước ban đầu
          _animationController.reverse(); // Quay ngược lại sau khi phóng to
        }
      });

    // Animation xoay vòng (2.0 * 3.14 là 1 vòng, nhân với 2-3 vòng)
    _rotationAnimation = Tween<double>(begin: 0, end: 5.28 * 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Đường cong chuyển động
      ),
    );

    // Animation thu phóng
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  // Hàm đếm số lượng số chẵn chia hết cho 3 từ 1 đến n
  int countEvenDivisible(int n) {
    if (n < 6) return 0; // Nếu n < 6 thì không có số nào chia hết cho 3
    return n ~/ 6; // Đếm số chẵn chia hết cho 3 (6 là bội của cả 2 và 3)
  }

  // Hàm tính tổng các số chẵn chia hết cho 3 từ 1 đến n
  int sumEvenDivisibleBy3(int n) {
    if (n < 6) return 0;
    int count = countEvenDivisible(n);
    return 6 * count * (count + 1) ~/ 2; // Công thức tính tổng
  }

  // Hàm xử lý khi nhấn nút "Tính Toán"
  void _calculate() {
    // Kiểm tra xem form đã được nhập đúng chưa
    if (_formKey.currentState!.validate()) {
      final int a = int.parse(_aController.text); // Lấy giá trị a
      final int b = int.parse(_bController.text); // Lấy giá trị b

      // Tính toán số lượng và tổng các số chẵn chia hết cho 3 từ 1 đến b và a-1
      int countB = countEvenDivisible(b);
      int sumB = sumEvenDivisibleBy3(b);

      int countA = countEvenDivisible(a - 1);
      int sumA = sumEvenDivisibleBy3(a - 1);

      // Tính số lượng và tổng các số chẵn chia hết cho 3 trong đoạn [a, b]
      int count = countB - countA;
      int totalSum = sumB - sumA;

      // Hiển thị kết quả trong hộp thoại
      if (totalSum > 0) {
        _showResultDialog(
            'Số lượng số chẵn chia hết cho 3: $count\nTổng của chúng: $totalSum');
      } else {
        _showResultDialog(
            'Không có số chẵn nào chia hết cho 3 trong đoạn [a, b].');
      }
    }
  }

  // Hàm hiển thị hộp thoại kết quả với hiệu ứng xoay và thu phóng
  void _showResultDialog(String result) {
    _animationController.forward(); // Bắt đầu hiệu ứng

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: _scaleAnimation, // Hiệu ứng thu phóng
          child: RotationTransition(
            turns: _rotationAnimation, // Hiệu ứng xoay
            child: AlertDialog(
              title: const Text('Kết quả',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
              content: Text(
                result, // Nội dung kết quả
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
                    Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn "OK"
                    _animationController
                        .reset(); // Reset animation sau khi đóng
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Số Chẵn Chia Hết Cho 3'), // Tiêu đề của ứng dụng
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Container tạo nền chuyển màu gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.lightBlueAccent
                  ], // Từ trắng đến xanh
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Giao diện form nhập liệu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Form(
                  key:
                      _formKey, // Gán key cho form để kiểm tra dữ liệu nhập vào
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Ô nhập giá trị a
                      TextFormField(
                        controller: _aController, // Liên kết với bộ điều khiển
                        keyboardType:
                            TextInputType.number, // Chỉ cho phép nhập số
                        decoration: const InputDecoration(
                          labelText: 'Nhập giá trị a',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.numbers),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập giá trị a'; // Kiểm tra nếu a rỗng
                          }
                          if (int.tryParse(value) == null) {
                            return 'Giá trị a phải là số nguyên hợp lệ'; // Kiểm tra nếu a không phải số
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Ô nhập giá trị b
                      TextFormField(
                        controller: _bController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Nhập giá trị b',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.numbers),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập giá trị b'; // Kiểm tra nếu b rỗng
                          }
                          if (int.tryParse(value) == null) {
                            return 'Giá trị b phải là số nguyên hợp lệ'; // Kiểm tra nếu b không phải số
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Nút "Tính Toán"
                      ElevatedButton(
                        onPressed: _calculate, // Gọi hàm tính toán khi nhấn nút
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
      ),
    );
  }
}
