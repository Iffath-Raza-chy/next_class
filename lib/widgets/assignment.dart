// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/countdown_painter.dart';

class Assignment extends StatefulWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  final Stream<QuerySnapshot> assignStream = FirebaseFirestore.instance
      .collection('assignment')
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
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
                DateTime alert = DateTime.parse(assignstoredocs[index]['time']);
                int hoursLeft = now.difference(alert).inHours;
                hoursLeft = hoursLeft < 0 ? -hoursLeft : 0;
                double percent = hoursLeft / 48;
                if (hoursLeft > 0) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                          decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    assignstoredocs[index]['name'],
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
                                        assignstoredocs[index]['sub'],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        DateFormat('EE, d-MMM, yyyy').format(
                                            DateTime.parse(
                                                assignstoredocs[index]
                                                    ['time'])),
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
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: Text("Choose a file"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey[100],
                                          minimumSize: Size(40, 25),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Theme.of(context)
                                              .secondaryHeaderColor,
                                          padding: EdgeInsets.all(10),
                                          minimumSize: Size(10.0, 10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text("Submit"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 8,
                                child: CustomPaint(
                                  foregroundPainter: CountdownPainter(
                                    bgColor: kBGColor,
                                    lineColor: _getColor(context, percent),
                                    percent: percent,
                                    width: 4.0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        ((MediaQuery.of(context).size.height *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                2) *
                                            .00011),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "$hoursLeft",
                                          style: TextStyle(
                                            color: _getColor(context, percent),
                                            fontSize: ((MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                    2) *
                                                .0002,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "hours left",
                                          style: TextStyle(
                                            color: _getColor(context, percent),
                                            fontSize: ((MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                    2) *
                                                .00007,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            );
          },
        ),
      ],
    );
  }

  _todoButton(homework) {
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

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.4) return Theme.of(context).colorScheme.secondary;

    return kHourColor;
  }
}
