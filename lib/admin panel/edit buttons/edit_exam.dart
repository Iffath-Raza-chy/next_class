import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';

class EditExam extends StatefulWidget {
  final String id;
  const EditExam({Key? key, required this.id}) : super(key: key);

  @override
  _EditExamState createState() => _EditExamState();
}

class _EditExamState extends State<EditExam> {
  @override
  Widget build(BuildContext context) {
    final _updateExamFormKey = GlobalKey<FormState>();
    CollectionReference updateExamstudents =
        FirebaseFirestore.instance.collection('exam');

    Future<void> updateExam(id, type, sub, time) {
      return updateExamstudents.doc(id).update(
          {'type': type, 'sub': sub, 'time': time}).then((value) => snackb = 1);
    }

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 280),
      child: Material(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Edit Exam Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _updateExamFormKey,
                      child:
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('exam')
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var data = snapshot.data!.data();
                          var type = data!['type'];
                          var sub = data['sub'];
                          var time = data['time'];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  initialValue: type,
                                  autofocus: false,
                                  onChanged: (value) => type = value,
                                  decoration: InputDecoration(
                                    labelText: 'Exam Name: ',
                                    labelStyle: TextStyle(fontSize: 20.0),
                                    border: OutlineInputBorder(),
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Exam Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  initialValue: sub,
                                  autofocus: false,
                                  onChanged: (value) => sub = value,
                                  decoration: InputDecoration(
                                    labelText: 'Subject: ',
                                    labelStyle: TextStyle(fontSize: 20.0),
                                    border: OutlineInputBorder(),
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Subject Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  initialValue: time,
                                  autofocus: false,
                                  onChanged: (value) => time = value,
                                  decoration: InputDecoration(
                                    labelText: 'Exam Date: ',
                                    labelStyle: TextStyle(fontSize: 20.0),
                                    border: OutlineInputBorder(),
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Exam Date';
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
                                      if (_updateExamFormKey.currentState!
                                          .validate()) {
                                        updateExam(widget.id, type, sub, time);
                                        Navigator.pop(context);
                                        if (snackb > 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                'Exam Updated Successfully',
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
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context)
                                            .secondaryHeaderColor),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
