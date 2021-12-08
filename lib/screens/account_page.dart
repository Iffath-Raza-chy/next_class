import 'package:flutter/material.dart';
import 'package:next_class/screens/login_page.dart';
import 'package:next_class/widgets/header.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: const [
          Header(),
          SizedBox(
            height: 300,
            child: LoginPage(),
          )
        ],
      ),
    );
  }
}
