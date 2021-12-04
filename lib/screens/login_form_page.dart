import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:next_class/screens/login_page.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginFormPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen(
      (User) {
        if (User != Null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                  image: AssetImage("assets/images/Login_Image.png"),
                  fit: BoxFit.contain),
            ),
            Container(
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
