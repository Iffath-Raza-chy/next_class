import 'package:cloud_firestore/cloud_firestore.dart';


class Classes {
  final String subject;
  final String type;
  final String teacherName;
  final DateTime time;
  bool isPassed = false;
  bool isHappening = false;

  Classes(
      {required this.subject,
      required this.type,
      required this.teacherName,
      required this.time});
}

final List<Classes> classes = [
  Classes(
    subject: "",
    type: "Online Class",
    teacherName: "Julie Raybon",
    time: DateTime.parse("2020-12-30 06:30:00"),
  ),
  Classes(
    subject: "Physics",
    type: "Online Class",
    teacherName: "Robert Murray",
    time: DateTime.parse("2021-12-30 08:30:00"),
  ),
  Classes(
    subject: "German",
    type: "Online Class",
    teacherName: "Mary Peterson",
    time: DateTime.parse("2021-12-30 10:30:00"),
  ),
  Classes(
    subject: "History",
    type: "Online Class",
    teacherName: "Jim Brooke",
    time: DateTime.parse("2021-12-30 20:30:00"),
  ),
];


// class ClassList {
//   String? uid;
//   String? date;
//   String? teacher;
//   String? duration;
//   String? time;

//   ClassList({this.uid, this.date, this.teacher, this.duration, this.time});

//   // receiving data from server
//   factory ClassList.fromMap(map) {
//     return ClassList(
//       uid: map['uid'],
//       date: map['date'],
//       teacher: map['teacher'],
//       duration: map['duration'],
//       time: map['time'],
//     );
//   }

//   // sending data to our server
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'date': date,
//       'teacher': teacher,
//       'duration': duration,
//       'time': time,
//     };
//   }
// }



