import 'package:flutter/material.dart';

const appLightColor = Color(0xff38E54D);
const appDarkColor = Color(0xff06283D);


ThemeData appLight = ThemeData(
  primaryColor: appLightColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: appLightColor
  ),
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
      color: Colors.black
    ),
    bodyText2:  TextStyle(
        color: Colors.black
    ),
  )
);

ThemeData appDark = ThemeData(
    primaryColor: appDarkColor,
    scaffoldBackgroundColor: appDarkColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: appDarkColor
    )
);