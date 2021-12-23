import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';
import 'package:intl/intl.dart';

class BuildClasses2 extends StatefulWidget {
  const BuildClasses2({Key? key}) : super(key: key);
  @override
  _BuildClasses2State createState() => _BuildClasses2State();
}

String dayname() {
  var sunday = 'snday';
  var monday = 'monday';
  var tuesday = 'tuesday';
  var wednesday = 'wednesday';
  var thursday = 'thursday';
  var friday = 'friday';
  var saturday = 'saturday';
  if (DateTime.now().weekday.toInt() == 1) {
    return monday;
  } else if (DateTime.now().weekday == 2) {
    return tuesday;
  } else if (DateTime.now().weekday == 3) {
    return wednesday;
  } else if (DateTime.now().weekday == 4) {
    return thursday;
  } else if (DateTime.now().weekday == 5) {
    return friday;
  } else if (DateTime.now().weekday == 6) {
    return saturday;
  } else {
    return sunday;
  }
}

class _BuildClasses2State extends State<BuildClasses2> {
  final Stream<QuerySnapshot> classStream = FirebaseFirestore.instance
      .collection(dayname())
      .orderBy('time')
      .snapshots();

  late DateFormat dateFormat = DateFormat("hh:mm a");
  bool se = true;
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: classStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Error();
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
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: storedocs.length,
          itemBuilder: (BuildContext context, int index) {
            var dateWOtime = DateFormat('yyyy-MM-dd').format(DateTime.now());
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

            final currentTime = DateTime.now();
            // List<String> str = [];
            // FirebaseFirestore.instance
            //     .collection(dayname())
            //     .orderBy('time')
            //     .get()
            //     .then((QuerySnapshot querySnapshot) {
            //   for (var doc in querySnapshot.docs) {
            //     str.add(doc.id.toString());
            //   }
            // });
            ishappening() {
              if (currentTime.isAfter(startTime) &&
                  currentTime.isBefore(endTime)) {
                {
                  return true;
                }
              } else {
                return false;
              }
            }

            ispassed() {
              if (currentTime.isBefore(endTime)) {
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
                    SizedBox(width: 20.0),
                    SizedBox(width: 20.0),

                    Flexible(
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
                    // c.isHappening
                    //     ?
                    ishappening()
                        ? Container(
                            height: 25.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Text(
                                "Now",
                                style: TextStyle(color: Colors.white),
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
                      height: 100.0,
                      color:
                          ispassed() ? kTextColor.withOpacity(0.3) : kTextColor,
                    ),
                    SizedBox(width: 28.0),
                    Column(
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
                            Text(
                              storedocs[index]['teacher'],
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
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 20.0),
              ],
            );
          },
        );
      },
    );
  }
}
