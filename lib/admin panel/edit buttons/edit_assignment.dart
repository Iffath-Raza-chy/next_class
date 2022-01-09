import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';

class EditAssignment extends StatefulWidget {
  final String id;
  const EditAssignment({Key? key, required this.id}) : super(key: key);

  @override
  _EditAssignmentState createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {
  final _updateAssignFormKey = GlobalKey<FormState>();
  CollectionReference updateAssignstudents =
      FirebaseFirestore.instance.collection('assignment');

  Future<void> updateAssign(id, name, sub, time) {
    return updateAssignstudents.doc(id).update(
        {'name': name, 'sub': sub, 'time': time}).then((value) => snackb = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 100),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[50],
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
                  padding: const EdgeInsets.only(
                      top: 30, left: 5, right: 5, bottom: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Edit Assignment Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _updateAssignFormKey,
                          child: FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance
                                .collection('assignment')
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
                                          Navigator.pop(context);
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
                              var name = data!['name'];
                              var sub = data['sub'];
                              var time = data['time'];
                              return Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: name,
                                      autofocus: false,
                                      onChanged: (value) => name = value,
                                      decoration: InputDecoration(
                                        labelText: 'Assignment Name: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Assignment Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: sub,
                                      autofocus: false,
                                      onChanged: (value) => sub = value,
                                      decoration: InputDecoration(
                                        labelText: 'Subject Name: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
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
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      initialValue: time,
                                      autofocus: false,
                                      onChanged: (value) => time = value,
                                      decoration: InputDecoration(
                                        labelText: 'DeadLine: ',
                                        labelStyle: TextStyle(fontSize: 20.0),
                                        border: OutlineInputBorder(),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Set a Deadline';
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
                                          if (_updateAssignFormKey.currentState!
                                              .validate()) {
                                            updateAssign(
                                                widget.id, name, sub, time);
                                            Navigator.pop(context);
                                            if (snackb > 0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    'Assignment Updated Successfully',
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
        ],
      ),
    );
  }
}
