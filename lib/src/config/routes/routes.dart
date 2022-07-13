import 'package:bloctemplate/src/config/router/routes.dart';
import 'package:bloctemplate/src/features/auth/bloc/auth_bloc.dart';
import 'package:firebase_auth_repository/firebase_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter routes(AuthBloc bloc) {
  return GoRouter(
    routes: [
      for (var route in Routes.values)
        createRoute(
          route: route,
        )
    ],
    redirect: (state) {
      final loggedIn = bloc.state.status == AuthenticationStatus.authenticated;
      final loggingIn = state.subloc == Routes.login.routePath;

      // List all intro screens
      if ([
        Routes.signUp.routePath,
        Routes.welcome.routePath,
        Routes.home.routePath
      ].contains(state.subloc)) {
        return null;
      }
      //If not on intro screens and logged go to '/'
      if (loggedIn) return Routes.home.routePath;

      //if not on logged
      if (!loggedIn) {
        // if going to /login return null (because contex.push will bring it) else return /intro
        // /intro will be the default screen when user is not authenticated and starts up app
        return loggingIn ? null : Routes.welcome.routePath;
      }
      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return Routes.home.routePath;
      }

      // no need to redirect at all
      // logged in and going to a different non-intro screen
      return null;
    },
    refreshListenable: GoRouterRefreshStream(bloc.stream),
  );
}

GoRoute createRoute({
  required Routes route,
}) =>
    GoRoute(
      path: route.routePath,
      name: route.routeName,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: route.routeView,
      ),
    );
