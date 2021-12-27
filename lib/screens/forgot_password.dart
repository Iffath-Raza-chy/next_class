import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Center(
          child: Text(
            "Next Class",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(8),
                          height: 60,
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 0, 10),
                        child: Text(
                          'A Reset Link will be sent to your email id !',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      Theme.of(context).secondaryHeaderColor),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  email = emailController.text;
                                }
                              },
                              child: Text(
                                'Send Email',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
