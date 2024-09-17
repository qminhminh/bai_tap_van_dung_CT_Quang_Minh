// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_import

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  // Utility method to get the current instance of MyAppState
  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }

  void setThemeMode(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exercises = [
      {'label': 'Bài tập 1', 'destination': BaiTap01()},
      {'label': 'Bài tập 2', 'destination': const BaiTap02()},
      {'label': 'Bài tập 3', 'destination': const BaiTap03()},
      {'label': 'Bài tập 4', 'destination': const BaiTap04()},
      {'label': 'Bài tập 5', 'destination': const BaiTap05()},
      {'label': 'Bài tập 6', 'destination': const BaiTap06()},
      {'label': 'Bài tập 7', 'destination': const BaiTap07()},
      {'label': 'Bài tập 8', 'destination': const BaiTap08()},
    ];

    return DefaultTabController(
      length: exercises.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách bài tập'),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  MyApp.of(context)?.setThemeMode(_isDarkMode);
                });
              },
            ),
          ],
          bottom: TabBar(
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            labelColor: Colors.red,
            tabs: exercises.map((exercise) {
              return Tab(text: exercise['label'] as String);
            }).toList(),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Bài Tập \n Ha Quang Minh',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ...exercises.map((exercise) {
                return ListTile(
                  title: Text(
                    exercise['label'] as String,
                    style: TextStyle(
                      fontFamily: FontWeight.bold.toString(),
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => exercise['destination'] as Widget,
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        ),
        body: TabBarView(
          children: exercises.map((exercise) {
            return exercise['destination'] as Widget;
          }).toList(),
        ),
      ),
    );
  }
}
