import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

late DateFormat dateFormat = DateFormat("hh:mm a");
var gCounter = DateTime.now().weekday.toInt();
var gCounter2 = DateTime.now().weekday.toInt();
var now = DateTime.now();
var ccnt = 0;
const kCardColor = Color(0xFF282B30);
const kHourColor = Color(0xFFF5C35A);
const kBGColor = Color(0xFF343537);

const kTextColor = Color(0xFF6C7174);
var snackb = 0;
const kCalendarDay = TextStyle(
  color: kTextColor,
  fontSize: 16.0,
);
const skCalendarDay = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
);

var calenderStyle = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
  background: Paint()
    ..strokeWidth = 17
    ..color = Color(0xFF63CF93)
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke,
);
var selectedCalenderContainerStyle = BoxDecoration(
  border: Border.all(),
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: Color(0xFF63CF93),
);
var calenderContainerStyle = BoxDecoration();
