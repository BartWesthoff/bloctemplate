import 'package:bloctemplate/constants/app_contants.dart';
import 'package:flutter/material.dart';
part 'light_theme.dart';

part 'dark_theme.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

final appThemeData = {
  AppTheme.lightTheme: lightTheme,
  AppTheme.darkTheme: darkTheme,
};
