import 'package:bloctemplate/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:bloctemplate/src/features/home/screen/home_screen.dart';
import 'package:bloctemplate/src/features/intro/screen/intro_screen.dart';
import 'package:bloctemplate/src/features/root/screen/root_screen.dart';
import 'package:bloctemplate/src/features/search/screen/search_screen.dart';
import 'package:bloctemplate/src/features/settings/screen/settings_screen.dart';
import 'package:bloctemplate/src/features/sign_up/screen/sign_up_page.dart';
import 'package:bloctemplate/src/features/signin/screen/sign_in_screen.dart';
import 'package:firebase_auth_repository/firebase_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String feature1 = '/feature1';
  static const String feature3 = '/feature3';
  static const String feature2 = '/feature2';
  static const String home = '/home';
  static const String initial = '/';

  static Map<String, Widget> map = {
    Routes.welcome: const IntroScreen(),
    Routes.login: const SignInScreen(),
    Routes.signUp: const SignUpScreen(),
    Routes.feature1: const Feature1Screen(),
    Routes.feature2: const Feature2Screen(),
    Routes.home: const HomeScreen(),
    Routes.feature3: const Feature3Screen(),
    Routes.initial: const IntroScreen(),
  };
}

GoRouter routes(AuthenticationBloc bloc) {
  return GoRouter(
    routes: [
      for (var key in Routes.map.keys)
        createRoute(
          path: key,
          widget: Routes.map[key]!,
        )
    ],
    redirect: (state) {
      final loggedIn = bloc.state.status == AuthenticationStatus.authenticated;
      final loggingIn = state.subloc == Routes.login;

      // List all intro screens
      if ([Routes.signUp, Routes.welcome, Routes.home].contains(state.subloc)) {
        return null;
      }
      //If not on intro screens and logged go to '/'
      if (loggedIn) return Routes.home;

      //if not on logged
      if (!loggedIn) {
        // if going to /login return null (because contex.push will bring it) else return /intro
        // /intro will be the default screen when user is not authenticated and starts up app
        return loggingIn ? null : Routes.welcome;
      }
      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return Routes.home;
      }

      // no need to redirect at all
      // logged in and going to a different non-intro screen
      return null;
    },
    refreshListenable: GoRouterRefreshStream(bloc.stream),
  );
}

GoRoute createRoute({required String path, required Widget widget}) => GoRoute(
      path: path,
      name: path == '/' ? path : path.substring(1),
      builder: (context, state) {
        return widget;
      },
    );
