import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAssignment extends StatefulWidget {
  String id;
  EditAssignment({Key? key, required this.id}) : super(key: key);

  @override
  _EditAssignmentState createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {
  final _updateAssignFormKey = GlobalKey<FormState>();
  CollectionReference updateAssignstudents =
      FirebaseFirestore.instance.collection('assignment');

  Future<void> updateAssign(id, name, sub, time) {
    return updateAssignstudents
        .doc(id)
        .update({'name': name, 'sub': sub, 'time': time})
        .then((value) => print("Updated"))
        .catchError((error) => print('Error'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 280),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text('Edit Assignment Data'),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _updateAssignFormKey,
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('assignment')
                        .doc(widget.id)
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        print('Something Went Wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              initialValue: name,
                              autofocus: false,
                              onChanged: (value) => name = value,
                              decoration: InputDecoration(
                                labelText: 'Name: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15),
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
                                  return 'Please Enter Email';
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
                                labelText: 'DeadLine: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    updateAssign(widget.id, name, sub, time);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        Theme.of(context).secondaryHeaderColor),
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
      ),
    );
  }
}
