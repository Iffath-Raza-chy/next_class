class Homework {
  final String title;
  final DateTime dueTime;
  bool isDone = false;

  Homework({required this.title, required this.dueTime});
}

List<Homework> recentHomeworks = [
  Homework(
    title: "Planimetric Exercises",
    dueTime: DateTime.parse("2021-12-12 11:30:00"),
  ),
  Homework(
    title: "Visicosity Exercises",
    dueTime: DateTime.parse("2021-12-12 21:30:00"),
  ),
];
