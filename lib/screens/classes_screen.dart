import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/build_classes.dart';
import 'package:next_class/widgets/build_classes2.dart';
import 'package:next_class/widgets/header.dart';
import 'package:intl/intl.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Header(),
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat('MMMM').format(now),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("${now.day - 3}", style: kCalendarDay),
                  Text("${now.day - 2}", style: kCalendarDay),
                  Text("${now.day - 1}", style: kCalendarDay),
                  Text(
                    "${now.day}",
                    style: kCalendarDay.copyWith(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text("${now.day + 1}", style: kCalendarDay),
                  Text("${now.day + 2}", style: kCalendarDay),
                  Text("${now.day + 3}", style: kCalendarDay),
                ],
              ),
              Center(
                child: Text(
                  DateFormat('EEE').format(now),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: Column(
            children: const <Widget>[
              BuildClasses2(),
            ],
          ),
        ),
      ],
    );
  }
}
