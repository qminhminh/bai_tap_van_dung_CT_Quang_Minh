// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _numberController = TextEditingController();
  String _draggedNumber = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Danh sách các số có thể kéo
  final List<String> _numbers = ['21322113', '31', '11', '21', '2111', '2211'];

  // Hàm giải mã chuỗi, tìm lại M từ N
  String decode(String encoded) {
    String current = encoded;

    while (true) {
      String next = '';
      int i = 0;

      while (i < current.length) {
        int repeatCount = int.parse(current[i]);
        String digit = current[i + 1];
        next += digit * repeatCount;
        i += 2;
      }

      if (next.length <= 3) {
        return next;
      }

      current = next;
    }
  }

  // Chức năng hiển thị kết quả trong hộp thoại
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Số gốc m',
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

  // Xử lý đầu vào giải mã
  void _decodeInput() {
    String input = _numberController.text.isEmpty
        ? _draggedNumber
        : _numberController.text;

    try {
      final String result = decode(input);
      _showResultDialog(result);
    } catch (e) {
      _showErrorDialog('Một lỗi đã xảy ra trong khi giải mã.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải mã số'),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.blueAccent,
        elevation: 5.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 50.0,
        titleSpacing: 16.0,
        toolbarOpacity: 1.0,
        bottomOpacity: 1.0,
        toolbarTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Thông tin ứng dụng'),
                    content: const Text(
                        'Ứng dụng giải mã số được mã hóa theo quy tắc: "số lần lặp" + "số"'),
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
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nhập số được mã hóa:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                strutStyle: StrutStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                locale: Locale('vi', 'VN'),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                // ignore: deprecated_member_use
                textScaleFactor: 1.0,
                maxLines: 2,
                semanticsLabel: 'Label for encoded number input',
                textWidthBasis: TextWidthBasis.parent,
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                selectionColor: Colors.blue,
              ),

              const SizedBox(
                height: 10,
                width: 20,
              ),
              Form(
                key: _formKey, // Chìa khóa để xác định biểu mẫu
                child: TextFormField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số được mã hóa',
                    prefixIcon: Icon(Icons.lock),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                  //Trình xác nhận để kiểm tra xem trường có trống không
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số được mã hóa';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _decodeInput,
                focusNode: FocusNode(),
                autofocus: false,
                clipBehavior: Clip.antiAlias,
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
                  'Giải mã',
                  style: TextStyle(
                    fontSize: 18, // Kích thước chữ
                    fontWeight: FontWeight.bold, // Kiểu chữ đậm
                    color: Colors.white, // Màu chữ
                  ),
                  strutStyle: StrutStyle(
                    fontSize: 18, // Chiều cao dòng tính theo kích thước chữ
                    height: 1.5, // Chiều cao dòng (line-height)
                  ),
                  textAlign: TextAlign.center, // Căn giữa chữ
                  textDirection:
                      TextDirection.ltr, // Hướng chữ từ trái sang phải
                  locale: Locale('vi', 'VN'), // Ngôn ngữ và vùng Việt Nam
                  softWrap: true, // Tự động xuống dòng nếu vượt quá không gian
                  overflow:
                      TextOverflow.ellipsis, // Thêm dấu "..." nếu chữ quá dài
                  // ignore: deprecated_member_use
                  textScaleFactor: 1.0, // Tỉ lệ kích thước chữ
                  maxLines: 2, // Giới hạn hiển thị tối đa 2 dòng
                  semanticsLabel:
                      'Nút giải mã', // Mô tả để hỗ trợ truy cập cho người dùng
                  textWidthBasis:
                      TextWidthBasis.parent, // Định nghĩa độ rộng chữ
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent:
                        false, // Không áp dụng chiều cao lên dòng đầu
                    applyHeightToLastDescent:
                        false, // Không áp dụng chiều cao lên dòng cuối
                  ),
                  selectionColor: Colors.blue, // Màu chữ khi được chọn
                ),
              ),
              const SizedBox(height: 20),
              // Các tiện ích có thể kéo cho mỗi số trong danh sách
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _numbers.map((number) {
                  return Draggable<String>(
                    data: number,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.blueAccent,
                      child: Text(
                        number,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    feedback: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.blueAccent.withOpacity(0.5),
                      child: Text(
                        number,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    childWhenDragging: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey,
                      child: Text(
                        number,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // kéo tiện ích mục tiêu
              DragTarget<String>(
                onAccept: (data) {
                  setState(() {
                    _draggedNumber = data;
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    height: 100,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text(
                        _draggedNumber.isEmpty
                            ? 'Kéo và thả số vào đây và Ấn nút giải mã'
                            : 'Số đã kéo: $_draggedNumber',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
