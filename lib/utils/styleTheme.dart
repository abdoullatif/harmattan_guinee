import 'package:flutter/material.dart';


ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: TextTheme(
      bodyText1: TextStyle(
        //color: Colors.grey[800],
        //fontWeight: FontWeight.bold,
        //fontSize: 40,
          color: Colors.black
      ),
      bodyText2: TextStyle(
        color: Colors.black,
      ),
      button: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.black),
      headline1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 21,
      ),
      overline: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
    buttonColor: Colors.white,
    cardColor: Colors.white,
    backgroundColor: Colors.black38,
    primaryColor: Colors.red,
    accentColor: Colors.redAccent,
    scaffoldBackgroundColor: Colors.white,

  );
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    textTheme: TextTheme(
      bodyText1: TextStyle(
        //color: Colors.grey[800],
        //fontWeight: FontWeight.bold,
        //fontSize: 40,
        color: Colors.white
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      button: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 21,
      ),
      overline: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
    buttonColor: Colors.white,
    cardColor: Colors.grey[800],
    backgroundColor: Colors.white70, //Colors.grey[800]
    primaryColor: Colors.blue[900],
    accentColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.grey[900],
    iconTheme: IconThemeData(color: Colors.white),
  );
}