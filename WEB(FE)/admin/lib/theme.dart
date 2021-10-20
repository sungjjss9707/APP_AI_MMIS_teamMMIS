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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.all(20),
      primary: Colors.black,
      fixedSize: Size(180, 80),
      minimumSize: Size(100, 50),
      side: BorderSide(
        width: 2.5,
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
    ),
  ),
  // iconTheme: IconThemeData(
  //   color: Colors.lightGreen[400],
  // ),
);
