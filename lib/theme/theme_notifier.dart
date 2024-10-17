import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {

    if(mode != _themeMode){ //only make changes in UI if old and new mode are not identical 
      _themeMode = mode;
      notifyListeners();
    }

  }

}