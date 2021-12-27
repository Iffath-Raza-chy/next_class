import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/models/alert.dart';
import 'package:next_class/widgets/countdown_painter.dart';

class HomeWorkwdg extends StatefulWidget {
  const HomeWorkwdg({Key? key}) : super(key: key);

  @override
  _HomeWorkwdgState createState() => _HomeWorkwdgState();
}

class _HomeWorkwdgState extends State<HomeWorkwdg> {
  DateFormat dateFormat = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
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
        ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: recentAlerts.length,
          itemBuilder: (BuildContext context, int index) {
            Alert alert = recentAlerts[index];
            int hoursLeft = now.difference(alert.time).inHours;
            hoursLeft = hoursLeft < 0 ? -hoursLeft : 0;
            double percent = hoursLeft / 48;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  height: 130,
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
                    height: 130,
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
                              alert.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              children: <Widget>[
                                Icon(
                                  AntDesign.clockcircle,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: 17.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "${now.weekday == alert.time.weekday ? "Today" : DateFormat.EEEE().format(alert.time)}, ${dateFormat.format(alert.time)}",
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
                                  Icons.receipt,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: 17.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  alert.subject,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 15.0,
                                  ),
                                ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
        )
      ],
    );
  }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.4) return Theme.of(context).colorScheme.secondary;

    return kHourColor;
  }
}
