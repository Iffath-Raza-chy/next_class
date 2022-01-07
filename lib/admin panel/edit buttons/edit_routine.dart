import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_class/admin%20panel/constantforRoutine.dart';
import 'package:next_class/constants.dart';

class EditRoutine extends StatefulWidget {
  String id;
  EditRoutine({Key? key, required this.id}) : super(key: key);

  @override
  _EditRoutineState createState() => _EditRoutineState();
}

class _EditRoutineState extends State<EditRoutine> {
  final _updateRoutineFormKey = GlobalKey<FormState>();
  CollectionReference updateRoutineCollection =
      FirebaseFirestore.instance.collection(dayn);

  Future<void> updateRoutine(
      id, sub, teacher, type, time, timehour, timeminute, classlink) {
    return updateRoutineCollection
        .doc(id)
        .update(
          {
            'classlink': classlink,
            'sub': sub,
            'teacher': teacher,
            'time': time,
            'timehour': int.parse(timehour),
            'timeminute': int.parse(timeminute),
            'type': type,
          },
        )
        .then((value) => snackb = 1)
        .catchError((error) => print('Error'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Edit Class Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _updateRoutineFormKey,
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection(dayn)
                        .doc(widget.id)
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Something Went Wrong!',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: Text('Try Again'),
                              )
                            ],
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data = snapshot.data!.data();
                      var type = data!['type'];
                      var sub = data['sub'];
                      var time = data['time'];
                      var teacher = data['teacher'];
                      var timehour = data['timehour'].toString();
                      var timeminute = data['timeminute'].toString();
                      var classlink = data['classlink'];
                      return Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 280),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 5, right: 5),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: sub,
                                      autofocus: false,
                                      onChanged: (value) => sub = value,
                                      decoration: InputDecoration(
                                        labelText: 'Subject: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: teacher,
                                      autofocus: false,
                                      onChanged: (value) => teacher = value,
                                      decoration: InputDecoration(
                                        labelText: 'Name: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: type,
                                      autofocus: false,
                                      onChanged: (value) => type = value,
                                      decoration: InputDecoration(
                                        labelText: 'Type: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: time,
                                      autofocus: false,
                                      onChanged: (value) => time = value,
                                      decoration: InputDecoration(
                                        labelText: 'Time: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: timehour,
                                      autofocus: false,
                                      onChanged: (value) => timehour = value,
                                      decoration: InputDecoration(
                                        labelText: 'Time Hour: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: timeminute,
                                      autofocus: false,
                                      onChanged: (value) => timeminute = value,
                                      decoration: InputDecoration(
                                        labelText: 'TimeMinute: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Reset',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue[300]),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          // Validate returns true if the form is valid, otherwise false.
                                          if (_updateRoutineFormKey
                                              .currentState!
                                              .validate()) {
                                            updateRoutine(
                                                widget.id,
                                                sub,
                                                teacher,
                                                type,
                                                time,
                                                timehour,
                                                timeminute,
                                                classlink);
                                            Navigator.pop(context);
                                            if (snackb > 0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    'Updated Successfully',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              );
                                              snackb = 0;
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Theme.of(context)
                                                .secondaryHeaderColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
