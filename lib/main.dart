// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isDarkMode = true;
  late TabController _tabController;

  final List<Widget> _pages = [
    BaiTap01(),
    const BaiTap02(),
    const BaiTap03(),
    const BaiTap04(),
    const BaiTap05(),
    const BaiTap06(),
    const BaiTap07(),
    const BaiTap08(),
  ];

  final List<String> _pageLabels = [
    'Bài tập 1',
    'Bài tập 2',
    'Bài tập 3',
    'Bài tập 4',
    'Bài tập 5',
    'Bài tập 6',
    'Bài tập 7',
    'Bài tập 8',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pageLabels.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
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
              controller: _tabController,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              labelColor: Colors.red,
              tabs: _pageLabels.map((label) => Tab(text: label)).toList(),
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
                ...List.generate(_pageLabels.length, (index) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          _tabController.index = _currentIndex;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        _pageLabels[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          body: (orientation == Orientation.portrait)
              ? TabBarView(
                  controller: _tabController,
                  children: _pages,
                )
              : Row(
                  children: [
                    Expanded(
                      child: Drawer(
                        child: ListView(
                          children: _pageLabels.map((label) {
                            return ListTile(
                              title: Text(label),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TabBarView(
                        controller: _tabController,
                        children: _pages,
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _tabController.index = _currentIndex;
              });
            },
            items: List.generate(_pageLabels.length, (index) {
              return BottomNavigationBarItem(
                icon: const Icon(Icons.book, color: Colors.black),
                label: _pageLabels[index],
                backgroundColor: Colors.blue,
              );
            }),
          ),
        );
      },
    );
  }
}
