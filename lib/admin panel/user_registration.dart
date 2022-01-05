import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter',
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (value) {},
          ),
          ElevatedButton(
            onPressed: () async {
              users.add(
                {
                  'name': 'Islam Rafat',
                  'email': 'iffatheaza@gmail.com',
                  'batch': '47',
                  'dob': '10-03-1999',
                },
              );
            },
            child: Text('submit'),
          ),
        ],
      ),
    );
  }
}
