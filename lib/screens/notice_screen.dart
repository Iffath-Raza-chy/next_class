import 'package:flutter/material.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/header.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
          height: 33.0,
        ),
        Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            color: Theme.of(context).primaryColor,
          ),
          child: ListView(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Hi"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
