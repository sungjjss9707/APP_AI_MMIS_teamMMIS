import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  backgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.lightGreen,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.lightGreen[500],
    ),
  ),
  // iconTheme: IconThemeData(
  //   color: Colors.lightGreen[400],
  // ),
);
