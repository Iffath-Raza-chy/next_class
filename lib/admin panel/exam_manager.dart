import 'package:flutter/material.dart';

class ExamManager extends StatefulWidget {
  const ExamManager({Key? key}) : super(key: key);

  @override
  _ExamManagerState createState() => _ExamManagerState();
}

class _ExamManagerState extends State<ExamManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
      body: Container(),
    );
  }
}
