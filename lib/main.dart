// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bai_tap_van_dung_cty/bai_tap_1.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_2.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_3.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_4.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_5.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_6.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_7.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_8.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap01()),
                    );
                  },
                  child: Text('Bài tập 1'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap02()),
                    );
                  },
                  child: Text('Bài tập 2'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap03()),
                    );
                  },
                  child: Text('Bài tập 3'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap04()),
                    );
                  },
                  child: Text('Bài tập 4'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap05()),
                    );
                  },
                  child: Text('Bài tập 5'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap06()),
                    );
                  },
                  child: Text('Bài tập 6'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap07()),
                    );
                  },
                  child: Text('Bài tập 7'),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BaiTap08()),
                    );
                  },
                  child: Text('Bài tập 8'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
