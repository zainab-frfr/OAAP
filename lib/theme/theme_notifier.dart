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

  Brightness getBrightness(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness;
  }
}

}