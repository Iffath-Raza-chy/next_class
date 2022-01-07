import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return exam
        .add({
          'classlink': classlink,
          'sub': sub,
          'teacher': teacher,
          'time': time.toString(),
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
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Class Details'),
          backgroundColor: Colors.transparent,
          actions: [
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (_addRoutineFormKey.currentState!.validate()) {
                  setState(
                    () {
                      type = routineTypeController.text;
                      sub = routineSubController.text;
                      teacher = routineTeacherController.text;
                      classlink = routineClassLinkController.text;
                      timehour = routineTimeHourController.text;
                      timeminute = routineTimeMinuteController.text;
                      addUser();
                      clearText();
                      time = "";
                      Navigator.pop(context);
                    },
                  );
                }
              },
              child: Text(
                'Publish',
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2.2,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[50],
                  ),
                  child: Form(
                    key: _addRoutineFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Subject Name",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              controller: routineSubController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Subject Name';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Teacher Name",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              controller: routineTeacherController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Teacher Name';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Class Delivery Type",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              controller: routineTypeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Class Delevry Type';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Class Duration (hour)",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              controller: routineTimeHourController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Class Duration in Hour (0-24)';
                                }
                                if (int.parse(value) > 20 ||
                                    int.parse(value) < 0) {
                                  return 'Enter between 0-24 only';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Class Duration (minute)",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              controller: routineTimeMinuteController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Class duration in Minute (1-59)';
                                }
                                if (int.parse(value) > 59 ||
                                    int.parse(value) < 0) {
                                  return 'Minute Must be 1-59';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Class Link",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              controller: routineClassLinkController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Provide a Class Link';
                                }
                              },
                            ),
                          ),
                          Stack(
                            children: [
                              Positioned(
                                  top: 20,
                                  child: GestureDetector(
                                    onTap: () async {
                                      _examTime = (await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ))!;
                                      setState(() {
                                        time = _examTime.format(context);
                                        time = DateFormat('HH:mm').format(
                                            DateFormat.jm().parse(time));
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.transparent,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: IgnorePointer(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      hintText: time.isEmpty
                                          ? "Pick a class Time"
                                          : DateFormat("hh:mm a").format(
                                              DateTime.parse(
                                                  "0000-00-00 " + time)),
                                      labelStyle: TextStyle(),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                          color: Colors.red, fontSize: 15),
                                    ),
                                    controller: routineTimeController,
                                    validator: (value) {
                                      if (time.isEmpty) {
                                        return 'Please Choose a Time';
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                clearText();
                                time = "";
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
