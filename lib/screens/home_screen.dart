
import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/header.dart';
import 'package:next_class/widgets/recents_alerts.dart';
import 'package:next_class/widgets/recents_homeworks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ListView(
          children: <Widget>[
            Header(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                style: TextStyle(color: kTextColor),
                cursorColor: kTextColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: InputBorder.none,
                  fillColor: Theme.of(context).primaryColor,
                  filled: true,
                  hintText: "Search",
                  hintStyle: TextStyle(color: kTextColor),
                  prefixIcon: Icon(Icons.search, color: kTextColor, size: 26.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.all(9.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Recent Alerts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  IgnorePointer(
                    child: RecentsAlerts(),
                  ),
                  Center(
                    child: Text(
                      "View all",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 15.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Recent Homework",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  IgnorePointer(
                    child: RecentHomeworks(),
                  ),
                  Center(
                    child: Text(
                      "View all",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 15.0),
                    ),
                  ),
                  SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
