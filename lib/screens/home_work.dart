import 'package:flutter/material.dart';
import 'package:next_class/widgets/assignment.dart';
import 'package:next_class/widgets/header.dart';
import 'package:next_class/widgets/examination.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({Key? key}) : super(key: key);

  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  var cnt = 1;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Header(),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cnt == 0
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 50,
                        width: 160,
                        child: Center(
                          child: Text(
                            'Assignment',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        cnt = 0;
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cnt == 1
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 50,
                        width: 160,
                        child: Center(
                          child: Text(
                            'Examination',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        cnt = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 31,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(9, 10, 9, 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (cnt == 0)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(1.5, 0), end: Offset(0, 0))
                                .animate(animation),
                            child: child,
                          );
                        },
                        child: Assignment(),
                      )
                    else
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(1.5, 0), end: Offset(0, 0))
                                .animate(animation),
                            child: child,
                          );
                        },
                        child: HomeWorkwdg(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
