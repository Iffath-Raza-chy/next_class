import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/build_classes2.dart';
import 'package:next_class/widgets/class_schedule_page_refresh.dart';
import 'package:next_class/widgets/header.dart';
import 'package:intl/intl.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  var nowonlyday = DateFormat('dd').format(now).toString();
  late final ValueNotifier<int> _counter = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Header(),
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMMM').format(now),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dayname(gCounter),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == -3
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          DateFormat('dd')
                              .format(now.subtract(Duration(days: 3))),
                          style: kCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 - 3;
                      _counter.value = -3;
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == -2
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          DateFormat('dd')
                              .format(now.subtract(Duration(days: 2))),
                          style: kCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 - 2;
                      _counter.value = -2;
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == -1
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          DateFormat('dd')
                              .format(now.subtract(Duration(days: 1))),
                          style: kCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 - 1;
                      _counter.value = -1;
                      setState(() {});
                    },
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == 0
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          "${now.day}",
                          style: skCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 - 0;
                      _counter.value = 0;
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == 1
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          DateFormat('dd').format(
                            now.add(Duration(days: 1)),
                          ),
                          style: kCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 + 1;
                      _counter.value = 1;
                      setState(() {});
                      if (gCounter > 7) {
                        gCounter = gCounter - 7;
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == 2
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          DateFormat('dd').format(now.add(Duration(days: 2))),
                          style: kCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 + 2;
                      _counter.value = 2;
                      if (gCounter > 7) {
                        gCounter = gCounter - 7;
                      }
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: _counter.value == 3
                          ? selectedCalenderContainerStyle
                          : calenderContainerStyle,
                      child: Center(
                        child: Text(
                          DateFormat('dd').format(now.add(Duration(days: 3))),
                          style: kCalendarDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      gCounter = gCounter2 + 3;
                      _counter.value = 3;
                      if (gCounter > 7) {
                        gCounter = gCounter - 7;
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Class Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              if (_counter.value == -3)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Psub3(),
                ),
              if (_counter.value == -2)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Psub2(),
                ),
              if (_counter.value == -1)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Psub1(),
                ),
              if (_counter.value == 0)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Padd0(),
                ),
              if (_counter.value == 1)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Padd1(),
                ),
              if (_counter.value == 2)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Padd2(),
                ),
              if (_counter.value == 3)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Padd3(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
