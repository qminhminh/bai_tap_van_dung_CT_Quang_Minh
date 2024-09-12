// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class BaiTap01 extends StatefulWidget {
  @override
  _BaiTap01State createState() => _BaiTap01State();
}

class _BaiTap01State extends State<BaiTap01> {
  final TextEditingController _controller = TextEditingController();

  // void _findOriginalNumber() {
  //   final String encodedNumber = _controller.text;
  //   final String decodedNumber = findOriginalNumber(encodedNumber);

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Original Number'),
  //         content: Text('Số ban đầu m là: $decodedNumber'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // String findOriginalNumber(String n) {
  //   String current = n;

  //   while (true) {
  //     String decoded = decodeOnce(current);
  //     if (decoded == current) {
  //       return decoded;
  //     }
  //     current = decoded;
  //   }
  // }

  // String decodeOnce(String encoded) {
  //   String decoded = '';
  //   int i = 0;

  //   while (i < encoded.length) {
  //     int count = 0;
  //     while (i + count < encoded.length && encoded[i] == encoded[i + count]) {
  //       count++;
  //     }
  //     decoded += encoded[i] * count;
  //     i += count;
  //   }

  //   return decoded;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải mã số'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số được mã hóa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: _findOriginalNumber,
            //   child: const Text('Find Original Number'),
            // ),
          ],
        ),
      ),
    );
  }
}
