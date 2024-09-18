// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'bai_tap_1.dart';
import 'bai_tap_2.dart';
import 'bai_tap_3.dart';
import 'bai_tap_4.dart';
import 'bai_tap_5.dart';
import 'bai_tap_6.dart';
import 'bai_tap_7.dart';
import 'bai_tap_8.dart';

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
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
    'B6',
    'B7',
    'B8',
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
            title: const Text('Danh sách bài tập => Switch chinh dark,light'),
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.red,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14.0,
                  ),
                  unselectedLabelColor: Colors.grey,
                  dragStartBehavior: DragStartBehavior.start,
                  indicatorWeight: 4.0,
                  indicatorColor: Colors.red,
                  isScrollable: true, // Cho phép cuộn ngang
                  tabs: _pageLabels.map((label) => Tab(text: label)).toList(),
                ),
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              scrollDirection: Axis.vertical,
              // ignore: prefer_const_constructors
              physics: BouncingScrollPhysics(),
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
          body: TabBarView(
            controller: _tabController,
            children: _pages,
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
            elevation: 8.0,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 16.0,
            unselectedFontSize: 14.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            mouseCursor: SystemMouseCursors.click,
            enableFeedback: true,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          ),
        );
      },
    );
  }
}
