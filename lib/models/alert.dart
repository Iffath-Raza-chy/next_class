import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Alert {
  final String title;
  final String subject;
  final DateTime time;

  Alert({required this.title, required this.subject, required this.time});
}

List<Alert> recentAlerts = [
  Alert(
    title: "Math Test",
    subject: "Trigonometry",
    time: DateTime.parse("2021-12-30 18:15:00"),
  ),
  Alert(
    title: "Physics Test",
    subject: "Gravitation",
    time: DateTime.parse("2021-12-30 14:30:00"),
  ),
];
