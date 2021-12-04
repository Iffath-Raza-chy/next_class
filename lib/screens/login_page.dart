import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 45,
        ),
        Image(
          image: AssetImage(
            "assets/images/Login_Image.png",
          ),
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Welcome To Next Class",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Login to Your School Account",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Log In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SignInButton(
          Buttons.Google,
          text: "Sign up with Google",
          onPressed: () {},
        )
      ],
    );
  }
}
