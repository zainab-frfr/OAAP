part of 'theme_bloc.dart';

sealed class ThemeEvent{
  const ThemeEvent();
}

final class ThemeChanged extends ThemeEvent{
  final String theme; // values may be 'System Theme', 'Light Theme', 'Dark Theme'
  final BuildContext? context;

  const ThemeChanged({required this.theme, required this.context});
}
