import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_class/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NextClass P300',
      theme: ThemeData(
        primaryColor: Color(0xFF202328),
        accentColor: Color(0xFF63CF93),
        backgroundColor: Color(0xFF12171D),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Yuu Have an error ${snapshot.error.toString()}');
              return Text('Something went Wrong');
            } else if (snapshot.hasData) {
              return WelcomeScreen();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          //WelcomeScreen(),
          ),
    );
  }
}
