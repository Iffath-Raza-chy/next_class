import 'package:flutter/material.dart';

class RoutineManager extends StatefulWidget {
  const RoutineManager({Key? key}) : super(key: key);
  

  @override
  _RoutineManagerState createState() => _RoutineManagerState();
}

class _RoutineManagerState extends State<RoutineManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print('pressed');
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(),
    );
  }
}
