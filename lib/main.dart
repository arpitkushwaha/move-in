import 'package:flutter/material.dart';
import 'package:move_in/utilities/db_manager.dart';
import 'package:move_in/views/IntroScreen.dart';
import 'package:move_in/views/homeScreen.dart';
import 'package:move_in/views/loginScreen.dart';
import 'package:move_in/views/selectAreaScreen.dart';
import 'package:move_in/views/signupScreen.dart';

import 'utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoveIn',
      routes: {
        '/': (context) => IntroScreen(),
        Constants.loginRoute : (context) => LoginScreen(),
        Constants.signupRoute : (context) => SignupScreen(),
        Constants.homeScreenRoute : (context) => HomeScreen(),
      },
    );
  }

  void initialize() {
    DbManager.connectToDB();
  }
}

