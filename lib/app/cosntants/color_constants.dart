import 'package:flutter/material.dart';

const appLightColor = Color(0xff38E54D);
const appDarkColor = Color(0xff06283D);


ThemeData appLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: appLightColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: appLightColor, elevation: 0
  ),
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
      color: Colors.black
    ),
    bodyText2:  TextStyle(
        color: Colors.black
    ),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.black
  ),

);

ThemeData appDark = ThemeData(

    brightness: Brightness.dark,
    primaryColor: appDarkColor,
    scaffoldBackgroundColor: appDarkColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: appDarkColor,  elevation: 0
    ),
    textTheme: const TextTheme(
      bodyText1:  TextStyle(
          color: Colors.white
      ),
      bodyText2:  TextStyle(
          color: Colors.white
      ),
    ),
    listTileTheme: const ListTileThemeData(
        textColor: Colors.white
    )
);