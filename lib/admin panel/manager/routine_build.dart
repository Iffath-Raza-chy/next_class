import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_class/admin%20panel/z_constantforRoutine.dart';
import 'package:next_class/admin%20panel/edit%20buttons/edit_routine.dart';
import 'package:next_class/constants.dart';

class BuildClassesForRoutineManager extends StatefulWidget {
  const BuildClassesForRoutineManager({Key? key}) : super(key: key);
  @override
  _BuildClassesForRoutineManagerState createState() =>
      _BuildClassesForRoutineManagerState();
}

String dayname(int a) {
  var sunday = 'Sunday';
  var monday = 'Monday';
  var tuesday = 'Tuesday';
  var wednesday = 'Wednesday';
  var thursday = 'Thursday';
  var friday = 'Friday';
  var saturday = 'Saturday';
  if (a == 1) {
    return monday;
  } else if (a == 2) {
    return tuesday;
  } else if (a == 3) {
    return wednesday;
  } else if (a == 4) {
    return thursday;
  } else if (a == 5) {
    return friday;
  } else if (a == 6) {
    return saturday;
  } else {
    return sunday;
  }
}

class _BuildClassesForRoutineManagerState
    extends State<BuildClassesForRoutineManager> {
  String time = "";
  CollectionReference routines = FirebaseFirestore.instance
      .collection(dayname(routineGCounter).toLowerCase());

  final Stream<QuerySnapshot> routineClassStream = FirebaseFirestore.instance
      .collection(dayname(routineGCounter).toLowerCase())
      .orderBy('sub')
      .snapshots();
  Future<void> deleteRoutine(id) {
    // print("User Deleted $id");
    return routines
        .doc(id)
        .delete()
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Class from Routine Deleted Successfully',
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
                'Failed To Delete Class Routine $error',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    dayn = dayname(routineGCounter).toLowerCase();
    var dwidth = MediaQuery.of(context).size.width;
    var dhight = MediaQuery.of(context).size.height;
    routineGCounter = DateTime.now().weekday.toInt();
    return StreamBuilder<QuerySnapshot>(
      stream: routineClassStream,
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
        final List routinestoredocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          routinestoredocs.add(a);
          a['id'] = document.id;
        }).toList();
        if (routinestoredocs.isEmpty) {
          return Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).secondaryHeaderColor),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 20),
                  child: Text(
                    'No Classes Avilable Today',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: routinestoredocs.length,
              itemBuilder: (BuildContext context, int index) {
                String duration =
                    routinestoredocs[index]['timehour'].toString() +
                        ":" +
                        routinestoredocs[index]['timeminute'].toString() +
                        " hr";
                time = "0000-00-00 " + routinestoredocs[index]['time'] + ":00";
                time = DateFormat('hh:ss a').format(DateTime.parse(time));

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(15)),
                        width: dwidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (_) => EditRoutine(
                                      id: routinestoredocs[index]['id']),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Subject',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Teacher',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Type',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Time',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Duration',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Class Link',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(': ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(': ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(': ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(': ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(': ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(': ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FittedBox(
                                      child:
                                          Text(routinestoredocs[index]['sub'])),
                                  FittedBox(
                                      child: Text(
                                          routinestoredocs[index]['teacher'])),
                                  Text(routinestoredocs[index]['type']),
                                  Text(time),
                                  Text(duration),
                                  Text(
                                    routinestoredocs[index]['classlink'],
                                    style: TextStyle(color: Colors.blue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
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
                                      'Are You sure you want to delete the Class',
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
                                          deleteRoutine(
                                              routinestoredocs[index]['id']);
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
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
