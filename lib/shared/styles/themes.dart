import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme =  ThemeData(
  primarySwatch: myColor,
  scaffoldBackgroundColor: HexColor('#3e3d3d'),
  appBarTheme: AppBarTheme(
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: HexColor('#3e3d3d'),
    elevation: 0.0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: myColor,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: myColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: myColor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: HexColor('#3e3d3d'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 14.5,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
ThemeData lightTheme =  ThemeData(
  primarySwatch: myColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: myColor,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: myColor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 14.5,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);