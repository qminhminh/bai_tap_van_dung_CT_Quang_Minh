// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bai_tap_van_dung_cty/bai_tap_1.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_2.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_3.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_4.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_5.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_6.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_7.dart';
import 'package:bai_tap_van_dung_cty/bai_tap_8.dart';
import 'package:bai_tap_van_dung_cty/compo_buttton.dart';
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
                ExerciseButton(
                  label: 'Bài tập 1',
                  destination: BaiTap01(),
                ),
                ExerciseButton(
                  label: 'Bài tập 2',
                  destination: BaiTap02(),
                ),
                ExerciseButton(
                  label: 'Bài tập 3',
                  destination: BaiTap03(),
                ),
                ExerciseButton(
                  label: 'Bài tập 4',
                  destination: BaiTap04(),
                ),
                ExerciseButton(
                  label: 'Bài tập 5',
                  destination: BaiTap05(),
                ),
                ExerciseButton(
                  label: 'Bài tập 6',
                  destination: BaiTap06(),
                ),
                ExerciseButton(
                  label: 'Bài tập 7',
                  destination: BaiTap07(),
                ),
                ExerciseButton(
                  label: 'Bài tập 8',
                  destination: BaiTap08(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
