import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/bottom_navigation.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({Key? key}) : super(key: key);

  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  CollectionReference assignemnt =
      FirebaseFirestore.instance.collection('assignment');

  late DateTime _assignDateTime;
  late TimeOfDay _assignTime;
  final _assignmentFormKey = GlobalKey<FormState>();
  var name = "";
  var sub = "";
  var time = "";
  var date = "";
  var finaltime = "";

  final assignNameController = TextEditingController();
  final assignsubController = TextEditingController();
  final assignTimeController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    assignNameController.dispose();
    assignsubController.dispose();
    assignTimeController.dispose();
    super.dispose();
  }

  clearText() {
    assignNameController.clear();
    assignsubController.clear();
    assignTimeController.clear();
  }

  Future<void> addUser() {
    finaltime = date + " " + time;
    return assignemnt
        .add({'name': name, 'sub': sub, 'time': finaltime})
        .then(
          (value) => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Center(
                child: Text('Success'),
              ),
              content: Image.asset(
                "assets/gif/successful.gif",
                fit: BoxFit.fitHeight,
              ),
              actionsAlignment: MainAxisAlignment.center,
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
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 200),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[50],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                            ),
                          ),
                          Form(
                            key: _assignmentFormKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 20, 30),
                                  child: Text(
                                    'Add Assignment Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Subject Name",
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
                                    controller: assignsubController,
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
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Assignment Name",
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
                                    controller: assignNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Assignment Name';
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        hintText: time.isEmpty
                                            ? "Pick a Deadline"
                                            : date + " " + time,
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
                                      controller: assignTimeController,
                                      validator: (value) {
                                        if (date.isEmpty || time.isEmpty) {
                                          return 'Please Enter Time';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () async {
                                          _assignDateTime =
                                              (await showDatePicker(
                                            context: context,
                                            initialDate: now,
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2030),
                                          ))!;
                                          setState(() {
                                            date = DateFormat("yyyy-MM-dd")
                                                .format(_assignDateTime)
                                                .toString();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            'Date',
                                            style: TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 2.2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () async {
                                          _assignTime = (await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ))!;
                                          setState(() {
                                            time = _assignTime.format(context);
                                            DateTime date =
                                                DateFormat.jm().parse(time);

                                            time = DateFormat('HH:mm:ss')
                                                .format(date)
                                                .toString();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            'Time',
                                            style: TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 2.2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            clearText();
                                            date = "";
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
                                      OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Theme.of(context)
                                              .secondaryHeaderColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_assignmentFormKey.currentState!
                                              .validate()) {
                                            setState(
                                              () {
                                                finaltime = date + " " + time;
                                                name =
                                                    assignNameController.text;
                                                sub = assignsubController.text;
                                                finaltime =
                                                    assignTimeController.text;
                                                addUser();
                                                clearText();

                                                Navigator.pop(context, true);
                                              },
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'Publish',
                                            style: TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 2.2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
