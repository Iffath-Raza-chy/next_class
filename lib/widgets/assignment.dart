// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/countdown_painter.dart';

import '../main.dart';

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
    var path;
    var fileName;
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
              return Center(
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
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List assignstoredocs = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map b = document.data() as Map<String, dynamic>;
              assignstoredocs.add(b);
              b['id'] = document.id;
            }).toList();
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: assignstoredocs.length,
              itemBuilder: (BuildContext context, int index) {
                String howmany = "";
                DateTime alert = DateTime.parse(assignstoredocs[index]['time']);
                int hoursLeft = now.difference(alert).inHours;
                int minsleft = now.difference(alert).inMinutes;
                int daysleft = now.difference(alert).inDays;
                hoursLeft = hoursLeft < 0 ? -hoursLeft : 0;
                minsleft = minsleft < 0 ? -minsleft : 0;
                daysleft = daysleft < 0 ? -daysleft : 0;
                double percent = hoursLeft / 48;

                int countdown;
                hoursLeft <= 0 && daysleft <= 0
                    ? countdown = minsleft
                    : countdown = hoursLeft;
                hoursLeft > 24 ? countdown = daysleft : countdown = hoursLeft;
                if (minsleft < 60 && minsleft > 0) {
                  countdown = minsleft;
                }
                if (hoursLeft <= 0 && daysleft <= 0) {
                  howmany = "mins";
                } else if (hoursLeft > 24) {
                  howmany = "days";
                } else {
                  howmany = "hours";
                }
                if ((hoursLeft >= 0 || minsleft >= 0 || daysleft >= 0) &&
                    assignstoredocs[index]['issubmitted'] == 'no') {
                  if (assignstoredocs[index]['notshowd'] == 'no') {
                    flutterLocNotPlug.show(
                      0,
                      'New Assignment for ${assignstoredocs[index]['sub']}',
                      assignstoredocs[index]['time'],
                      NotificationDetails(
                        android: AndroidNotificationDetails(
                            channel.id, channel.name,
                            channelDescription: channel.description,
                            importance: Importance.high,
                            color: Theme.of(context).secondaryHeaderColor,
                            playSound: true,
                            icon: '@mipmap/ic_launcher'),
                      ),
                    );
                    FirebaseFirestore.instance
                        .collection('assignment')
                        .doc(assignstoredocs[index]['id'])
                        .update({'notshowd': 'yes'});
                  }
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
                                        onPressed: () async {
                                          final resutls = await FilePicker
                                              .platform
                                              .pickFiles(
                                            allowMultiple: false,
                                            type: FileType.any,
                                            allowCompression: true,
                                          );
                                          if (resutls != null) {
                                            setState(
                                              () {
                                                path =
                                                    resutls.files.single.path;
                                                fileName =
                                                    resutls.files.single.name;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'File Picked, Now Submit'),
                                                  ),
                                                );
                                              },
                                            );
                                          }

                                          if (resutls == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('No File Picked'),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text("Choose a file"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey[100],
                                          minimumSize: Size(40, 25),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
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
                                        onPressed: () async {
                                          setState(() {
                                            FirebaseFirestore.instance
                                                .collection('assignment')
                                                .doc(assignstoredocs[index]
                                                    ['id'])
                                                .update({
                                              'issubmitted': 'yes'
                                            }).then((value) => ScaffoldMessenger
                                                        .of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                          'Assignmetn Submited',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))));
                                          });
                                        },
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
                                        DateTime.now().isBefore(DateTime.parse(
                                                assignstoredocs[index]['time']))
                                            ? Text(
                                                "$countdown",
                                                style: TextStyle(
                                                  color: _getColor(
                                                      context, percent),
                                                  fontSize: ((MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width) /
                                                          2) *
                                                      .0002,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : assignstoredocs[index]
                                                        ['issubmitted'] ==
                                                    'no'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Missing',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Submitted',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                        DateTime.now().isAfter(DateTime.parse(
                                                assignstoredocs[index]['time']))
                                            ? Container()
                                            : Text(
                                                "$howmany left",
                                                style: TextStyle(
                                                  color: _getColor(
                                                      context, percent),
                                                  fontSize: ((MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              MediaQuery.of(
                                                                      context)
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

  // _todoButton(homework) {
  //   return RaisedButton(
  //     onPressed: () {
  //       setState(() {
  //         homework.isDone = !homework.isDone;
  //       });
  //     },
  //     shape: CircleBorder(
  //       side: BorderSide(color: Theme.of(context).secondaryHeaderColor),
  //     ),
  //     color: homework.isDone
  //         ? Theme.of(context).secondaryHeaderColor
  //         : Colors.transparent,
  //     child: homework.isDone ? Icon(Icons.check, color: Colors.white) : null,
  //   );
  // }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.4) return Theme.of(context).colorScheme.secondary;

    return kHourColor;
  }
}
