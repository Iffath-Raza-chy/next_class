import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Center(
          child: Text(
            'All Assignment',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
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
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAssignment(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: addAssignStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('something went wrong');
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    assignstoredocs[index]['sub'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    assignstoredocs[index]['name'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => EditAssignment(
                                    //         id: assignstoredocs[index]['id']),
                                    //   ),
                                    // );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                Text(
                                  assignstoredocs[index]['time'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
