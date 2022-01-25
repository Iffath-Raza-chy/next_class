import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_class/admin%20panel/addButton%20pages/add_assignment.dart';
import 'package:next_class/admin%20panel/edit%20buttons/edit_assignment.dart';


class AssignmentManager extends StatefulWidget {
  const AssignmentManager({Key? key}) : super(key: key);

  @override
  _AssignmentManagerState createState() => _AssignmentManagerState();
}

class _AssignmentManagerState extends State<AssignmentManager> {
  CollectionReference assignemnt =
      FirebaseFirestore.instance.collection('assignment');
  final Stream<QuerySnapshot> addAssignStream = FirebaseFirestore.instance
      .collection('assignment')
      .orderBy('sub')
      .snapshots();

  Future<void> deleteAssignment(id) {
    // print("User Deleted $id");
    return assignemnt
        .doc(id)
        .delete()
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Assignment Deleted Successfully',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
        .catchError(
          (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Failed To Delete Assignmetn $error',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text(
          'Assignment Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Icon(Icons.add),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) => AddAssignment(),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: addAssignStream,
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
          final List assignstoredocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            assignstoredocs.add(a);
            a['id'] = document.id;
          }).toList();
          return ListView.builder(
            itemCount: assignstoredocs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Subject',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                assignstoredocs[index]['sub'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                assignstoredocs[index]['name'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => EditAssignment(
                                      id: assignstoredocs[index]['id']),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            Text(
                              DateFormat('E, d/M/yyyy (h:mm a)').format(
                                  DateTime.parse(
                                      assignstoredocs[index]['time'])),
                              style: TextStyle(fontSize: 15),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Center(
                                      child: Text(
                                        'Warning',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    content: Text(
                                      'Are You sure you want to delete the Assignment',
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                        ),
                                        onPressed: () {
                                          deleteAssignment(
                                              assignstoredocs[index]['id']);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Sure",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            'Deadline',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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
