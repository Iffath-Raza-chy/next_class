import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_class/admin%20panel/addButton%20pages/add_routine.dart';
import 'package:next_class/admin%20panel/constantforRoutine.dart';
import 'package:next_class/admin%20panel/refreshClass.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/build_classes2.dart';

class RoutineManager extends StatefulWidget {
  const RoutineManager({Key? key}) : super(key: key);

  @override
  _RoutineManagerState createState() => _RoutineManagerState();
}

class _RoutineManagerState extends State<RoutineManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).backgroundColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddRoutine()));
            },
            icon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      dayname(routineGCounter),
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
                        decoration: routineGCounter == 7
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            'Sun',
                            style: DateTime.now().weekday.toInt() == 7
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 7;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: routineGCounter == 1
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            'Mon',
                            style: DateTime.now().weekday.toInt() == 1
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 1;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: routineGCounter == 2
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            'Tue',
                            style: DateTime.now().weekday.toInt() == 2
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 2;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: routineGCounter == 3
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            'Wed',
                            style: DateTime.now().weekday.toInt() == 3
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 3;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: routineGCounter == 4
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            "Thu",
                            style: DateTime.now().weekday.toInt() == 4
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 4;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: routineGCounter == 5
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            'Fri',
                            style: DateTime.now().weekday.toInt() == 5
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 5;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: routineGCounter == 6
                            ? selectedCalenderContainerStyle
                            : calenderContainerStyle,
                        child: Center(
                          child: Text(
                            'Sat',
                            style: DateTime.now().weekday.toInt() == 6
                                ? skCalendarDay
                                : kCalendarDay,
                          ),
                        ),
                      ),
                      onTap: () {
                        routineGCounter = 6;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (routineGCounter == 1) DayMonday(),
          if (routineGCounter == 2) DayTuesday(),
          if (routineGCounter == 3) DayWednesday(),
          if (routineGCounter == 4) DayThursday(),
          if (routineGCounter == 5) DayFriday(),
          if (routineGCounter == 6) DaySaturday(),
          if (routineGCounter == 7) DaySunday()
        ],
      ),
    );
  }
}
