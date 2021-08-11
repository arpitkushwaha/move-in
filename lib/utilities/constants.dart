import 'package:flutter/material.dart';

class Constants{
  //Colors
  static const int introScreenBackgroundColor = 0xffffffff;
  static const int primaryColor = 0xA9A9A9;

  //Routes
  static const String signupRoute = "/signup";
  static const String loginRoute = "/login";
  static const String homeScreenRoute = "/homeScreen";
  static const String compareCitiesScreenRoute = "/compareCitiesScreen";
  static const String selectedCityScreenRoute = "/selectedCityScreen";

  //Constants
  static final kHintTextStyle = TextStyle(
    color: Colors.white54,
    fontFamily: 'Itim',
  );

  static final kLabelStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Itim',
  );

  static final kBoxDecorationStyle = BoxDecoration(
    color: Color(0xFF6CA8F1),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}