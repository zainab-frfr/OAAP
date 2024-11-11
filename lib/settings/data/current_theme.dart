import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme{
    String _themeString = '';

    String get themeString => _themeString;
    
    Future<void> setTheme(String theme) async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme', theme);
    }

    Future<String> getTheme() async{
      final prefs = await SharedPreferences.getInstance();

      _themeString = prefs.getString('theme') ?? 'Light Theme';
      return _themeString;
    }
}