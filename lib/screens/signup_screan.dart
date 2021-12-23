import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  var id = "";
  var password = "";

  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() {
    idController.clear();
    passwordController.clear();
  }

//adding students`
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> addUser() {
    return students
        .add(
          {'id': id, 'password': password},
        )
        .then(
          (value) => Text('User Added'),
        )
        .catchError(
          (error) => Text('Failed to Add user: $error'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New User"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Id: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: idController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Id';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordController,
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(
                          () {
                            id = idController.text;
                            password = passwordController.text;
                            addUser();
                            clearText();
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {clearText()},
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
