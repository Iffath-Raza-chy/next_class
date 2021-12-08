import 'package:flutter/material.dart';
import 'package:next_class/screens/account_page.dart';
import 'package:next_class/screens/login_page.dart';
import 'package:next_class/widgets/header.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Header(),
          SizedBox(
            height: 300,
            child: Expanded(
              child: Container(
                color: Colors.white,
                height: 50,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                              ),
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              } else if (!value.contains('@')) {
                                return 'Please Enter Valid EMail';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 0, 10),
                          child: Text(
                            'A Reset Link will be sent to your email id !',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    email = emailController.text;
                                  }
                                },
                                child: Text(
                                  'Send Email',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            AccountPage(),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ),
                                      (route) => false)
                                },
                                child: Text('Login'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
