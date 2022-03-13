part of 'themes.dart';

ThemeData darkTheme = ThemeData(
  backgroundColor: const Color(0xffFAFAFA),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppConstants.primarycolor,
    primary: AppConstants.primarycolor,
    brightness: Brightness.dark,
    outline: AppConstants.primarycolor,
  ),
);
