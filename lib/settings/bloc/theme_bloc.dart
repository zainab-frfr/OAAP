import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState> {
  ThemeBloc():super(const ThemeInitial(ThemeMode.light, Brightness.light, 'Light Theme')){ //when app opens I want light theme
    //add events here
    on<ThemeChanged>(_themeChanged);
  }

  void _themeChanged(ThemeChanged event, Emitter<ThemeState> emit){
    switch (event.theme) {
      case 'System Theme':
        Brightness brightness = MediaQuery.of(event.context).platformBrightness;
        emit(ThemeSystem(ThemeMode.system,brightness, event.theme));
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