import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      // primarySwatch: Colors.red,
      // accentColor: Colors.green,
      primarySwatch: isDarkTheme ? Colors.grey : Colors.red,
      primaryColor: isDarkTheme ? Colors.grey : Colors.red,
      accentColor: isDarkTheme ? Color(0xff999999) : Colors.red,
      canvasColor: isDarkTheme ? Color(0xff555555) : Colors.blue[400],
      buttonColor: isDarkTheme ? Colors.black : Colors.red,
      errorColor: isDarkTheme ? Color(0xff999999) : Colors.red,
      hintColor: isDarkTheme ? Colors.white : Colors.black,
      primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      // buttonTheme: ButtonThemeData(
      //   textTheme: ButtonTextTheme.accent,
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
