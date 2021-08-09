import 'package:flutter/material.dart';
import 'package:move_in/utilities/constants.dart';


class Commons{

  static InputDecoration buildInputDecoration(IconData icons, String hinttext) {
    return InputDecoration(
      hintText: hinttext,
      prefixIcon: IconButton(
        icon: Icon(icons),
        onPressed: null,
        color: Color(Constants.primaryColor),
      ),

      filled: true,
      fillColor: Colors.white,

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(15.0),
        ),
        borderSide: BorderSide(color: Colors.black, width: 1.5),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
    );
  }
}
