import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:oaap/settings/data/current_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState> {
  ThemeBloc():super(const ThemeInitial(ThemeMode.light, Brightness.light, 'Light Theme')){ //when app opens I want light theme
    // Initialize the theme on app start
    initializeTheme();
    //add events here
    on<ThemeChanged>(_themeChanged);
  }

  Future<void> initializeTheme() async {
    final theme = await CurrentTheme().getTheme();
    add(ThemeChanged(theme: theme, context: null));
  }

  void _themeChanged(ThemeChanged event, Emitter<ThemeState> emit){
    
    // Save the selected theme to SharedPreferences
    CurrentTheme().setTheme(event.theme);

    switch (event.theme) {
      case 'System Theme':
        //Brightness brightness = MediaQuery.of(event.context!).platformBrightness;
        emit(ThemeSystem(ThemeMode.system,Brightness.light, event.theme));
        break;  
      case 'Light Theme':
        emit(ThemeLight(ThemeMode.light,Brightness.light, event.theme));
        break;  
      case 'Dark Theme':
        emit(ThemeDark(ThemeMode.dark,Brightness.dark, event.theme));
        break;  
      default:
    }
  }
   
}

// bonkerssssssssss :PPPP
class FirstClass {
  final int _value;

  const FirstClass({required int value}) : _value = value;
}

class SecondClass {
  final FirstClass first = const FirstClass(value: 45);

  void printValue() {
    debugPrint(first._value.toString());
  }
}