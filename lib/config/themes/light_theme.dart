part of 'themes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppConstants.primarycolor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppConstants.primarycolor,
    primary: AppConstants.primarycolor,
    outline: Colors.grey,
    // brightness: Brightness.light,
  ),
);
