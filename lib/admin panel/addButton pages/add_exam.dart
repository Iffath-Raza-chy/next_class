import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';

class AddExam extends StatefulWidget {
  const AddExam({Key? key}) : super(key: key);

  @override
  _AddExamState createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {
  CollectionReference exam = FirebaseFirestore.instance.collection('exam');

  late DateTime _examDateTime;
  late TimeOfDay _examTime;
  final _examFormKey = GlobalKey<FormState>();
  var type = "";
  var sub = "";
  var time = "";
  var date = "";
  var finaltime = "";
  var hour = "";
  var min = "";
  var deltype = "";
  var examlink = "";

  final examTypeController = TextEditingController();
  final examSubController = TextEditingController();
  final examTimeController = TextEditingController();
  final examHourController = TextEditingController();
  final examMinController = TextEditingController();
  final examDeltypeController = TextEditingController();
  final examExamlinkController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    examTypeController.dispose();
    examSubController.dispose();
    examTimeController.dispose();
    examHourController.dispose();
    examMinController.dispose();
    examDeltypeController.dispose();
    examExamlinkController.dispose();
    super.dispose();
  }

  clearText() {
    examTypeController.clear();
    examSubController.clear();
    examTimeController.clear();
    examHourController.clear();
    examMinController.clear();
    examDeltypeController.clear();
    examExamlinkController.clear();
  }

  Future<void> addExam() {
    finaltime = date + " " + time;
    return exam
        .add({
          'type': type,
          'sub': sub,
          'time': finaltime,
          'hour': int.parse(hour),
          'minute': int.parse(min),
          'deltype': deltype,
          'examlink': examlink,
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          SizedBox(
            height: 40,
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
                          key: _examFormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
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
                                    errorStyle: TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                  controller: examSubController,
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
                                    labelText: "Exam Type",
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
                                  controller: examTypeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Exam Type';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "Duration (hour 0-24)",
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
                                  controller: examHourController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter hour';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "Duration (Minute 0-59)",
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
                                  controller: examMinController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Minute';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText:
                                        "Submission Method(Email/Google Form/Offline)",
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
                                  controller: examDeltypeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Submission Method(Offline/Email/Google Form)';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "Exam Link (If any)",
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
                                  controller: examExamlinkController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      deltype = "";
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
                                          ? "Pick an Exam Date"
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
                                    controller: examTimeController,
                                    validator: (value) {
                                      if (date.isEmpty || time.isEmpty) {
                                        return 'Please Choose a Time';
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                                        _examDateTime = (await showDatePicker(
                                          context: context,
                                          initialDate: now,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030),
                                        ))!;
                                        setState(() {
                                          date = DateFormat("yyyy-MM-dd")
                                              .format(_examDateTime)
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
                                        _examTime = (await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ))!;
                                        setState(() {
                                          time = _examTime.format(context);
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
                                        if (_examFormKey.currentState!
                                            .validate()) {
                                          setState(
                                            () {
                                              finaltime = date + " " + time;
                                              type = examTypeController.text;
                                              sub = examSubController.text;
                                              finaltime =
                                                  examTimeController.text;
                                              hour = examHourController.text;
                                              min = examMinController.text;
                                              deltype =
                                                  examDeltypeController.text;
                                              examlink =
                                                  examExamlinkController.text;
                                              addExam();
                                              clearText();

                                              Navigator.pop(context);
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
    );
  }
}
