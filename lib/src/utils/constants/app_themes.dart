import 'package:bloctemplate/src/utils/constants/app_contants.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppConstants.scaffoldcolorDark,
  colorSchemeSeed: AppConstants.primarycolor,
  useMaterial3: true,
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: AppConstants.primarycolor,
  useMaterial3: true,
);

enum AppTheme {
  lightTheme,
  darkTheme,
}

final appThemeData = {
  AppTheme.lightTheme: lightTheme,
  AppTheme.darkTheme: darkTheme,
};
