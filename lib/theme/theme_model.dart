import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  canvasColor: Colors.grey[100]!, //background color of UI components like theme toggle tile
  scaffoldBackgroundColor: Colors.white, 
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  canvasColor: const Color.fromARGB(255, 36, 35, 35),
  scaffoldBackgroundColor: Colors.grey[900]!, 
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent
  ),
);