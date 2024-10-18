import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  canvasColor: Colors.grey[100]!, //background color of UI components like theme toggle tile
  scaffoldBackgroundColor: Colors.white, 
  appBarTheme: const AppBarTheme( //for color of app bar
    backgroundColor: Colors.transparent
  ),
  colorSchemeSeed: Colors.blue, // generates a full color scheme based on Material design guidelines (for eg. cursor color)
  inputDecorationTheme: const InputDecorationTheme( // for decoration of text fields
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 62, 100, 131)),
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  canvasColor: const Color.fromARGB(255, 36, 35, 35),
  scaffoldBackgroundColor: Colors.grey[900]!, 
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent
  ),
  colorSchemeSeed: Colors.blue,
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
  )
);