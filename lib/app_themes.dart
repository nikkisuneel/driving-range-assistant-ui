import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.black),
          headline5: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          color: Colors.grey[800],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          labelStyle: TextStyle(color: Colors.black),
          focusColor: Colors.black,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[800],
          selectedItemColor: Colors.white38,
          unselectedItemColor: Colors.white,
        ),
    );
  }
}