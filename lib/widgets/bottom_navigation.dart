// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/screens/classes_screen.dart';
import 'package:next_class/screens/home_screen.dart';
import 'package:next_class/screens/notice_screen.dart';
import 'package:next_class/screens/test_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedTab = 0;
  late Widget _currentPage;
  late List<Widget> _pages;

  late HomeScreen _homeScreen;
  late ClassesScreen _classesScreen;
  late TestScreen _testScreen;
  late NoticeScreen _noticeScreen;

  @override
  void initState() {
    super.initState();
    _homeScreen = HomeScreen();
    _classesScreen = ClassesScreen();
    _testScreen = TestScreen();
    _noticeScreen = NoticeScreen();
    _pages = [_homeScreen, _classesScreen, _testScreen, _noticeScreen];
    _currentPage = _homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    now = DateTime.now();
    gCounter = now.weekday.toInt();
    gCounter2 = now.weekday.toInt();

    ccnt = 0;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          _currentPage,
          _bottomNavigator(),
        ],
      ),
    );
  }

  _bottomNavigator() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey[900],
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(
              () {
                _selectedTab = index;
                if (index == 0 || index == 1) {
                  _currentPage = _pages[index];
                } else if (index == 2) {
                  _currentPage = _pages[index];
                } else if (index == 3) {
                  _currentPage = _pages[index];
                }
              },
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/house.svg",
                width: 35.0,
                color: _selectedTab == 0
                    ? Theme.of(context).secondaryHeaderColor
                    : kTextColor,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/read_book.svg",
                width: 35.0,
                color: _selectedTab == 1
                    ? Theme.of(context).secondaryHeaderColor
                    : kTextColor,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/homework.svg",
                width: 35.0,
                color: _selectedTab == 2
                    ? Theme.of(context).secondaryHeaderColor
                    : kTextColor,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/comment.svg",
                width: 35.0,
                color: _selectedTab == 3
                    ? Theme.of(context).secondaryHeaderColor
                    : kTextColor,
              ),
              title: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
