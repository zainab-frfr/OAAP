part of 'theme_bloc.dart';

sealed class ThemeState{
  final ThemeMode themeMode;
  final Brightness brightness;
  final String themeString;
  const ThemeState(this.themeMode, this.brightness, this.themeString);
}

final class ThemeInitial extends ThemeState{
  const ThemeInitial(super.themeMode, super.brightness, super.themeString);
}

final class ThemeDark extends ThemeState{
  const ThemeDark(super.themeMode, super.brightness, super.themeString);
}

final class ThemeLight extends ThemeState{
  const ThemeLight(super.themeMode, super.brightness, super.themeString);
}

final class ThemeSystem extends ThemeState{
  const ThemeSystem(super.themeMode, super.brightness, super.themeString);
}