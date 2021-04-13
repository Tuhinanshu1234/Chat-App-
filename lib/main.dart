import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:page_transition/page_transition.dart';

import 'Screens/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SplashScreen(
              seconds: 13,
              backgroundColor: Color(0xff273A4F),
              image: Image.asset('asset/final-icon.gif'),
              loaderColor: Colors.white,
              photoSize: 200.0,
              navigateAfterSeconds: Mylog(),
            ),
          ),
        ]);
  }
}
