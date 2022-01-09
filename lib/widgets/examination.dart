// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/countdown_painter.dart';

class Examination extends StatefulWidget {
  const Examination({Key? key}) : super(key: key);

  @override
  _ExaminationState createState() => _ExaminationState();
}

class _ExaminationState extends State<Examination> {
  final Stream<QuerySnapshot> examStream =
      FirebaseFirestore.instance.collection('exam').orderBy('time').snapshots();
  DateFormat dateFormat = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Examination",
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
            stream: examStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              final List examstoredocs = [];
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map c = document.data() as Map<String, dynamic>;
                examstoredocs.add(c);
              }).toList();

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: examstoredocs.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime alert = DateTime.parse(examstoredocs[index]['time']);
                  int hoursLeft = now.difference(alert).inHours;
                  hoursLeft = hoursLeft < 0 ? -hoursLeft : 0;
                  double percent = hoursLeft / 48;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        height: MediaQuery.of(context).size.height * .20,
                        width: 15.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                          height: MediaQuery.of(context).size.height * .20,
                          decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    examstoredocs[index]['type'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.book_sharp,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        size: 17.0,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        examstoredocs[index]['sub'],
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        AntDesign.clockcircle,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        size: 17.0,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        DateFormat('EEEE, d, MMM, yyyy').format(
                                            DateTime.parse(
                                                examstoredocs[index]['time'])),
                                        // "${now.weekday == alert.time.weekday ? "Today" : DateFormat.EEEE().format(alert.time)}, ${dateFormat.format(alert.time)}",
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.link_rounded,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        size: 17,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Exam Link : ',
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Text(
                                          "Google Form",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 15),
                                        ),
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 10.0,
                                child: CustomPaint(
                                  foregroundPainter: CountdownPainter(
                                    bgColor: kBGColor,
                                    lineColor: _getColor(context, percent),
                                    percent: percent,
                                    width: 5.0,
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
                },
              );
            })
      ],
    );
  }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.4) return Theme.of(context).colorScheme.secondary;

    return kHourColor;
  }

  // _launchURL() async {
  //   const url = 'https://flutter.io';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
