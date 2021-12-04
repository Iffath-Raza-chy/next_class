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
    time: DateTime.parse("2021-12-03 18:15:00"),
  ),
  Alert(
    title: "Physics Test",
    subject: "Gravitation",
    time: DateTime.parse("2020-06-06 14:30:00"),
  ),
];
