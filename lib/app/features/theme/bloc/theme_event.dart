part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final int themeNumber;

  const ThemeChanged({
    required this.themeNumber,
  });
}
