import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_class/admin%20panel/constantforRoutine.dart';

class AddRoutine extends StatefulWidget {
  const AddRoutine({Key? key}) : super(key: key);

  @override
  _AddRoutineState createState() => _AddRoutineState();
}

class _AddRoutineState extends State<AddRoutine> {
  CollectionReference exam = FirebaseFirestore.instance.collection(dayn);

  late DateTime _examDateTime;
  late TimeOfDay _examTime;
  final _addRoutineFormKey = GlobalKey<FormState>();
  var type = "";
  var sub = "";
  var time = "";
  var timeminute = "";
  var timehour = "";
  var teacher = "";
  var classlink = "";
  var finaltime = "";

  final routineTypeController = TextEditingController();
  final routineSubController = TextEditingController();
  final routineTimeController = TextEditingController();
  final routineTimeHourController = TextEditingController();
  final routineTimeMinuteController = TextEditingController();
  final routineTeacherController = TextEditingController();
  final routineClassLinkController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    routineTypeController.dispose();
    routineSubController.dispose();
    routineTimeController.dispose();
    routineTimeHourController.dispose();
    routineTimeMinuteController.dispose();
    routineTeacherController.dispose();
    routineClassLinkController.dispose();
    super.dispose();
  }

  clearText() {
    routineTypeController.clear();
    routineSubController.clear();
    routineTimeController.clear();
    routineTimeHourController.clear();
    routineTimeMinuteController.clear();
    routineTeacherController.clear();
    routineClassLinkController.clear();
  }

  Future<void> addUser() {
    // finaltime = date + " " + time;
    return exam
        .add({
          'classlink': classlink,
          'sub': sub,
          'teacher': teacher,
          'time': time,
          'timehour': int.parse(timehour),
          'timeminute': int.parse(timeminute),
          'type': type,
        })
        .then(
          (value) => showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => AlertDialog(
              title: Center(
                child: Text('Success'),
              ),
              content: Image.asset(
                "assets/gif/successful.gif",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        )
        .catchError(
          (error) => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.red,
              title: Text('Error'),
              content: Text('Something Went Wrong $error'),
            ),
            barrierDismissible: true,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
