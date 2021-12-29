// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/countdown_painter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWorkwdg extends StatefulWidget {
  const HomeWorkwdg({Key? key}) : super(key: key);

  @override
  _HomeWorkwdgState createState() => _HomeWorkwdgState();
}

class _HomeWorkwdgState extends State<HomeWorkwdg> {
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
                return Center(child: Text('Error'));
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

              // DateTime dates = DateTime.parse(examstoredocs[0]['time']);

              // print(DateFormat('hh dd a').format(dates));

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
                        height: 150,
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
                          height: 170,
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
                                      Text(
                                        'Google Meet ',
                                        style: TextStyle(
                                          color: kTextColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _launchURL,
                                        icon: Icon(
                                          Icons.open_in_browser,
                                        ),
                                        color: Colors.white,
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
                                    width: 4.0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "$hoursLeft",
                                          style: TextStyle(
                                            color: _getColor(context, percent),
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "hours left",
                                          style: TextStyle(
                                            color: _getColor(context, percent),
                                            fontSize: 13.0,
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

  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
