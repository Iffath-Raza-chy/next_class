import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_class/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light),
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Center(
            child: Column(
              children: [
                Text(
                  'Something Went Wrong!',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Try Again'),
                )
              ],
            ),
          );
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
        return Center(
          child: const CircularProgressIndicator(),
        );
      },
    );
  }
}
