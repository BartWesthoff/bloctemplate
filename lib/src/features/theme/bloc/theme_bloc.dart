import 'package:bloc/bloc.dart';
import 'package:bloctemplate/src/utils/constants/app_themes.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeNumber: 1)) {
    on<ThemeChanged>(
      (event, emit) => emit(ThemeState(themeNumber: event.themeNumber)),
    );
  }
}
