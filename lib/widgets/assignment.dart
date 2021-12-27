import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/models/homework.dart';

class Assignment extends StatefulWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  final Stream<QuerySnapshot> assignStream = FirebaseFirestore.instance
      .collection('assignment')
      .orderBy('timeday')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    DateFormat dateFormat = DateFormat("hh:mm a");
    return Column(
      children: [
        Text(
          "Assignment",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: assignStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List assignstoredocs = [];
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map b = document.data() as Map<String, dynamic>;
                assignstoredocs.add(b);
              }).toList();
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: assignstoredocs.length,
                itemBuilder: (BuildContext context, int index) {
                  Homework homework = recentHomeworks[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                          height: deviceHeight * 0.16,
                          width: deviceWidth * 0.86,
                          decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    assignstoredocs[index]['sub'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        AntDesign.book,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        size: 17.0,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        assignstoredocs[index]['name'],
                                        // "${now.weekday == homework.dueTime.weekday ? "Today" : DateFormat.EEEE().format(homework.dueTime)}, ${dateFormat.format(homework.dueTime)}",
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        AntDesign.clockcircle,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        size: 17.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        assignstoredocs[index]['timeday'],
                                        // "${now.weekday == homework.dueTime.weekday ? "Today" : DateFormat.EEEE().format(homework.dueTime)}, ${dateFormat.format(homework.dueTime)}",
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              //  _todoButton(homework)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      ],
    );
  }

  _todoButton(Homework homework) {
    return RaisedButton(
      onPressed: () {
        setState(() {
          homework.isDone = !homework.isDone;
        });
      },
      shape: CircleBorder(
        side: BorderSide(color: Theme.of(context).secondaryHeaderColor),
      ),
      color: homework.isDone
          ? Theme.of(context).secondaryHeaderColor
          : Colors.transparent,
      child: homework.isDone ? Icon(Icons.check, color: Colors.white) : null,
    );
  }
}
