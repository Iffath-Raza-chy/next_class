import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_class/admin%20panel/addButton%20pages/add_users.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  CollectionReference allUsers = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('users')
      .orderBy('name')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text('User Registration'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddUsers(),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          final List userstoredocs = [];
          snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              userstoredocs.add(a);
              a['id'] = document.id;
            },
          ).toList();

          return ListView.builder(
            itemCount: userstoredocs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    tileColor: Theme.of(context).secondaryHeaderColor,
                    dense: true,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(userstoredocs[index]['imageurl']),
                    ),
                    title: Text(
                      userstoredocs[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userstoredocs[index]['email']),
                        Text(userstoredocs[index]['dob']),
                        Text(userstoredocs[index]['batch']),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
