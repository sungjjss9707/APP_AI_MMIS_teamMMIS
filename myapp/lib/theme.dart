import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.lightGreen[400],
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.lightGreen[400],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.lightGreen[500];
        } else {
          return Colors.lightGreen[400];
        }
      }),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.lightGreen[500],
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.lightGreen[400],
  ),
);
