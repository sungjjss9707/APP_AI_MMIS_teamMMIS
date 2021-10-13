import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  textTheme: TextTheme(),
  fontFamily: "NotoSansKR",
  backgroundColor: Colors.white,
  primaryColor: Colors.lightGreen,
  accentColor: Colors.lightGreenAccent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.lightGreen[400],
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
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

ThemeData SurveyTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.lightGreen,
    ).copyWith(onPrimary: Colors.lightGreen),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.lightGreen,
      ),
      textTheme: TextTheme(
        button: TextStyle(
          color: Colors.lightGreen,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(150.0, 60.0),
        ),
        side: MaterialStateProperty.resolveWith(
          (Set<MaterialState> state) {
            if (state.contains(MaterialState.disabled)) {
              return BorderSide(
                color: Colors.grey,
              );
            }
            return BorderSide(
              color: Colors.lightGreen,
            );
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (Set<MaterialState> state) {
            if (state.contains(MaterialState.disabled)) {
              return Theme.of(context).textTheme.button?.copyWith(
                    color: Colors.grey,
                  );
            }
            return Theme.of(context).textTheme.button?.copyWith(
                  color: Colors.lightGreen,
                );
          },
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.button?.copyWith(
                color: Colors.lightGreen,
              ),
        ),
      ),
    ),
  );
}
