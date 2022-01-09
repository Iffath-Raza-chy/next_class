import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_class/models/user_model.dart';
import 'package:next_class/screens/login_page.dart';
import 'package:next_class/screens/profile.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel logedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        logedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/grad_cap.png",
            height: 70.0,
          ),
          Text(
            "Next Class",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              if (FirebaseAuth.instance.currentUser == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              }
            },
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(logedInUser.imageurl.toString()),
            ),
          )
        ],
      ),
    );
  }
}
