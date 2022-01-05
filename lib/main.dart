import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_class/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Center(
              child: Text("Something Went Wrong",
                  style: TextStyle(
                    color: Colors.white,
                  )));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NextClass P300',
            theme: ThemeData(
              primaryColor: Color(0xFF202328),
              secondaryHeaderColor: Color(0xFF63CF93),
              backgroundColor: Color(0xFF12171D),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme:
                  AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
            ),
            home: WelcomeScreen(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
