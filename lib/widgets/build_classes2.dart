import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildClasses2 extends StatefulWidget {
  const BuildClasses2({Key? key}) : super(key: key);
  @override
  _BuildClasses2State createState() => _BuildClasses2State();
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

class _BuildClasses2State extends State<BuildClasses2> {
  DatabaseReference scoresRef = FirebaseDatabase.instance.reference();

  final Stream<QuerySnapshot> classStream = FirebaseFirestore.instance
      .collection(dayname(gCounter).toLowerCase())
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: classStream,
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

        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
        }).toList();
        if (storedocs.isEmpty) {
          return Column(
            children: const [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                child: Text(
                  'No Classes Today',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        } else {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: storedocs.length,
            itemBuilder: (BuildContext context, int index) {
              var dateWOtime = DateFormat('yyyy-MM-dd').format(now);
              var dateWtime = storedocs[index]['time'].toString();
              var finaltime = dateWOtime + " " + dateWtime + ":00";
              var classtime = DateTime.parse(finaltime);
              var startTime = DateTime.parse(finaltime);
              var addedtime = startTime
                  .add(Duration(
                      hours: storedocs[index]['timehour'],
                      minutes: storedocs[index]['timeminute']))
                  .toString();
              var endTime = DateTime.parse(addedtime);

              final currentTime = now;

              ishappening() {
                if (currentTime.isAfter(startTime) &&
                    currentTime.isBefore(endTime) &&
                    gCounter == classtime.weekday) {
                  {
                    return true;
                  }
                } else {
                  return false;
                }
              }

              ispassed() {
                if (currentTime.isBefore(endTime) &&
                    gCounter == classtime.weekday) {
                  return false;
                } else {
                  return true;
                }
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        dateFormat.format(classtime).toString(),
                        style: TextStyle(
                          color: ispassed()
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white,
                          fontSize: 18.0,
                        ),
                        maxLines: 2,
                        softWrap: true,
                      ),
                      SizedBox(width: 40.0),
                      Expanded(
                        child: Text(
                          storedocs[index]['sub'],
                          style: TextStyle(
                            color: ispassed()
                                ? Colors.white.withOpacity(0.2)
                                : Colors.white,
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      ishappening()
                          ? Container(
                              height: 30.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 117.0, bottom: 20.0),
                        width: 2,
                        height: 75.0,
                        color: ispassed()
                            ? kTextColor.withOpacity(0.3)
                            : kTextColor,
                      ),
                      SizedBox(width: 28.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: ispassed()
                                      ? Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.3)
                                      : Theme.of(context).secondaryHeaderColor,
                                  size: 20.0,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  storedocs[index]['type'],
                                  style: TextStyle(
                                    color: ispassed()
                                        ? kTextColor.withOpacity(0.3)
                                        : kTextColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: ispassed()
                                      ? Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.3)
                                      : Theme.of(context).secondaryHeaderColor,
                                  size: 20.0,
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    storedocs[index]['teacher'],
                                    style: TextStyle(
                                      color: ispassed()
                                          ? kTextColor.withOpacity(0.3)
                                          : kTextColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.link,
                                  color: ispassed()
                                      ? Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.3)
                                      : Theme.of(context).secondaryHeaderColor,
                                  size: 20.0,
                                ),
                                SizedBox(width: 8.0),
                                InkWell(
                                  splashColor: Colors.green,
                                  onTap: () async {
                                    final url = storedocs[index]['classlink'];
                                    if (await canLaunch(url) && ishappening()) {
                                      await launch(url);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          duration: Duration(milliseconds: 500),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          backgroundColor: Colors.blue,
                                          content: Text(
                                            'Link will be activated during class',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Class Link",
                                    style: TextStyle(
                                      color: ispassed()
                                          ? Colors.blue.withOpacity(0.3)
                                          : Colors.blue,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0),
                ],
              );
            },
          );
        }
      },
    );
  }
}
