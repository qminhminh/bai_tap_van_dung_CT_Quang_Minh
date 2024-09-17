// ignore_for_file: unused_element, sort_child_properties_last

import 'package:flutter/material.dart';

class BaiTap05 extends StatefulWidget {
  const BaiTap05({super.key});

  @override
  State<BaiTap05> createState() => _BaiTap05State();
}

class _BaiTap05State extends State<BaiTap05> {
  final TextEditingController _nController =
      TextEditingController(); // Controller cho số lượng cuộc thi
  final TextEditingController _examsController =
      TextEditingController(); // Controller cho thời gian cuộc thi
  final List<List<int>> _exams = []; // Danh sách chứa thông tin các cuộc thi
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      // Lấy số lượng cuộc thi
      final List<String> lines =
          _examsController.text.split('\n'); // Tách từng dòng dữ liệu
      _exams.clear(); // Xóa danh sách các cuộc thi trước đó

      // Chuyển đổi từng dòng dữ liệu thành danh sách các cuộc thi
      for (var line in lines) {
        final List<int> times = line.split(',').map(int.parse).toList();
        if (times.length == 2) {
          _exams.add(times); // Thêm cuộc thi vào danh sách
        }
      }

      _exams.sort((a, b) =>
          a[0].compareTo(b[0])); // Sắp xếp cuộc thi theo thời gian bắt đầu

      List<int> endTimes =
          []; // Danh sách theo dõi thời gian kết thúc các phòng thi
      int rooms = 0; // Biến đếm số phòng

      // Duyệt qua từng cuộc thi để tính số phòng cần dùng
      for (var exam in _exams) {
        int start = exam[0]; // Thời gian bắt đầu cuộc thi
        int end = exam[1]; // Thời gian kết thúc cuộc thi

        // Kiểm tra và tái sử dụng phòng đã kết thúc trước thời gian bắt đầu cuộc thi
        bool roomFound = false;
        for (int i = 0; i < endTimes.length; i++) {
          if (endTimes[i] <= start) {
            endTimes[i] = end; // Cập nhật thời gian kết thúc phòng
            roomFound = true;
            break;
          }
        }

        if (!roomFound) {
          endTimes.add(end); // Mở thêm một phòng mới
          rooms++;
        }
      }

      // Hiển thị kết quả qua dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Kết quả',
                style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
            content: Text('Số phòng tối thiểu cần dùng: $rooms',
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 25)), // Nội dung của dialog
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text('OK'), // Nút OK để đóng dialog
              ),
            ],
          );
        },
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error',
              style: TextStyle(color: Colors.blueAccent, fontSize: 30)),
          content: Text(message,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 30)),
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
        title: const Text('Xếp phòng thi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding xung quanh các widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nController,
                    decoration: InputDecoration(
                      labelText: 'Nhập số lượng cuộc thi (N)',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.numbers),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16), // Khoảng cách giữa các widget
                  TextFormField(
                    controller: _examsController,
                    decoration: InputDecoration(
                      labelText:
                          'Nhập thời gian bắt đầu và kết thúc cho từng cuộc thi\nVD: 1,2\n2,3',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.schedule),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    maxLines: null, // Cho phép nhiều dòng nhập liệu
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Khoảng cách giữa các widget
            ElevatedButton(
              onPressed: _calculate, // Hàm gọi khi nhấn nút
              child:
                  const Text('Tính số phòng', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Màu nền của nút
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0), // Padding bên trong nút
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
