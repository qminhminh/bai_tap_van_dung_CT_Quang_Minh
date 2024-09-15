import 'package:flutter/material.dart';

class BaiTap08 extends StatefulWidget {
  const BaiTap08({super.key});

  @override
  State<BaiTap08> createState() => _BaiTap08State();
}

class _BaiTap08State extends State<BaiTap08> {
  // Khởi tạo các TextEditingController để nhận dữ liệu nhập từ bàn phím
  final TextEditingController _x1Controller = TextEditingController();
  final TextEditingController _y1Controller = TextEditingController();
  final TextEditingController _x2Controller = TextEditingController();
  final TextEditingController _y2Controller = TextEditingController();
  final TextEditingController _x3Controller = TextEditingController();
  final TextEditingController _y3Controller = TextEditingController();
  final TextEditingController _a1Controller = TextEditingController();
  final TextEditingController _b1Controller = TextEditingController();
  final TextEditingController _c1Controller = TextEditingController();
  final TextEditingController _a2Controller = TextEditingController();
  final TextEditingController _b2Controller = TextEditingController();
  final TextEditingController _c2Controller = TextEditingController();
  final TextEditingController _a3Controller = TextEditingController();
  final TextEditingController _b3Controller = TextEditingController();
  final TextEditingController _c3Controller = TextEditingController();

  // Hàm tính tổng tiền điện cho cả 3 loại điện
  int calculateElectricityBill(int x1, int y1, int x2, int y2, int x3, int y3,
      int a1, int b1, int c1, int a2, int b2, int c2, int a3, int b3, int c3) {
    // Tính tiền điện tiêu dùng
    int tieuDung = calculateUsage(x1, y1, a1, b1, c1, 50, 100);
    // Tính tiền điện sản xuất
    int sanXuat = calculateUsage(x2, y2, a2, b2, c2, 200, 800);
    // Tính tiền điện kinh doanh
    int kinhDoanh = calculateUsage(x3, y3, a3, b3, c3, 100, 100);
    // Trả về tổng số tiền phải trả
    return tieuDung + sanXuat + kinhDoanh;
  }

  // Hàm tính toán tiền điện cho từng loại
  int calculateUsage(
      int start, int end, int a, int b, int c, int limit1, int limit2) {
    // Tính tổng lượng điện tiêu thụ trong tháng
    int totalpasspower = end - start;
    int cost = 0; // Biến lưu tổng chi phí cho loại điện này

    // Kiểm tra nếu tiêu thụ trong giới hạn 1
    if (totalpasspower <= limit1) {
      cost =
          totalpasspower * a; // Nếu tiêu thụ nhỏ hơn giới hạn 1, tính với giá A
    }
    // Kiểm tra nếu tiêu thụ trong giới hạn 2
    else if (totalpasspower <= limit1 + limit2) {
      // Tính tiền cho giới hạn 1 và phần còn lại trong giới hạn 2
      cost = limit1 * a + (totalpasspower - limit1) * b;
    }
    // Nếu tiêu thụ vượt qua giới hạn 2
    else {
      // Tính tiền cho cả giới hạn 1, giới hạn 2 và phần vượt giới hạn
      cost = limit1 * a + limit2 * b + (totalpasspower - limit1 - limit2) * c;
    }

    return cost; // Trả về tổng chi phí cho loại điện này
  }

  // Hàm hiển thị kết quả dưới dạng popup
  void _showResult(BuildContext context, int result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả'), // Tiêu đề của popup
          content: Text(
              'Tổng số tiền điện phải trả: $result đồng'), // Nội dung popup
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng popup khi nhấn OK
              },
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính tiền điện'), // Tiêu đề trên thanh AppBar
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16.0), // Thêm khoảng cách xung quanh nội dung
        child: Column(
          children: <Widget>[
            // TextField để nhập chỉ số điện tiêu dùng X1
            TextField(
              controller: _x1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nhập chỉ số X1 (điện tiêu dùng)'),
            ),
            // TextField để nhập chỉ số điện tiêu dùng Y1
            TextField(
              controller: _y1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nhập chỉ số Y1 (điện tiêu dùng)'),
            ),
            // TextField để nhập chỉ số điện sản xuất X2
            TextField(
              controller: _x2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nhập chỉ số X2 (điện sản xuất)'),
            ),
            // TextField để nhập chỉ số điện sản xuất Y2
            TextField(
              controller: _y2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nhập chỉ số Y2 (điện sản xuất)'),
            ),
            // TextField để nhập chỉ số điện kinh doanh X3
            TextField(
              controller: _x3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nhập chỉ số X3 (điện kinh doanh)'),
            ),
            // TextField để nhập chỉ số điện kinh doanh Y3
            TextField(
              controller: _y3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nhập chỉ số Y3 (điện kinh doanh)'),
            ),
            // TextField để nhập giá A1 (điện tiêu dùng)
            TextField(
              controller: _a1Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá A1 (tiêu dùng)'),
            ),
            // TextField để nhập giá B1 (điện tiêu dùng)
            TextField(
              controller: _b1Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá B1 (tiêu dùng)'),
            ),
            // TextField để nhập giá C1 (điện tiêu dùng)
            TextField(
              controller: _c1Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá C1 (tiêu dùng)'),
            ),
            // TextField để nhập giá A2 (điện sản xuất)
            TextField(
              controller: _a2Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá A2 (sản xuất)'),
            ),
            // TextField để nhập giá B2 (điện sản xuất)
            TextField(
              controller: _b2Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá B2 (sản xuất)'),
            ),
            // TextField để nhập giá C2 (điện sản xuất)
            TextField(
              controller: _c2Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá C2 (sản xuất)'),
            ),
            // TextField để nhập giá A3 (điện kinh doanh)
            TextField(
              controller: _a3Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá A3 (kinh doanh)'),
            ),
            // TextField để nhập giá B3 (điện kinh doanh)
            TextField(
              controller: _b3Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá B3 (kinh doanh)'),
            ),
            // TextField để nhập giá C3 (điện kinh doanh)
            TextField(
              controller: _c3Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nhập giá C3 (kinh doanh)'),
            ),
            // Nút bấm để tính toán và hiển thị kết quả
            ElevatedButton(
              child: const Text('Tính tiền điện'),
              onPressed: () {
                // Lấy dữ liệu từ các TextEditingController và chuyển đổi sang số nguyên
                int x1 = int.tryParse(_x1Controller.text) ?? 0;
                int y1 = int.tryParse(_y1Controller.text) ?? 0;
                int x2 = int.tryParse(_x2Controller.text) ?? 0;
                int y2 = int.tryParse(_y2Controller.text) ?? 0;
                int x3 = int.tryParse(_x3Controller.text) ?? 0;
                int y3 = int.tryParse(_y3Controller.text) ?? 0;
                int a1 = int.tryParse(_a1Controller.text) ?? 0;
                int b1 = int.tryParse(_b1Controller.text) ?? 0;
                int c1 = int.tryParse(_c1Controller.text) ?? 0;
                int a2 = int.tryParse(_a2Controller.text) ?? 0;
                int b2 = int.tryParse(_b2Controller.text) ?? 0;
                int c2 = int.tryParse(_c2Controller.text) ?? 0;
                int a3 = int.tryParse(_a3Controller.text) ?? 0;
                int b3 = int.tryParse(_b3Controller.text) ?? 0;
                int c3 = int.tryParse(_c3Controller.text) ?? 0;

                // Tính tổng số tiền điện và hiển thị kết quả
                int totalAmount = calculateElectricityBill(
                    x1, y1, x2, y2, x3, y3, a1, b1, c1, a2, b2, c2, a3, b3, c3);
                _showResult(context, totalAmount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
