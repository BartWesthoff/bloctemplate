import 'dart:io';

import 'package:bloctemplate/src/config/routes/routes.dart';
import 'package:bloctemplate/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:bloctemplate/src/features/root/bloc/nav_bar_cubit.dart';
import 'package:bloctemplate/src/features/theme/theme.dart';
import 'package:firebase_auth_repository/firebase_authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<ThemeBloc>(
            create: (BuildContext context) => ThemeBloc(),
          ),
          BlocProvider<NavBarCubit>(
            create: (BuildContext context) => NavBarCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter router = routes(context.read<AuthenticationBloc>());
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        FlutterNativeSplash.remove();
        final platformIsIOS = Platform.isIOS;
        final cupertinoApp = Theme(
          data: state.theme,
          child: CupertinoApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            debugShowCheckedModeBanner: false,
          ),
        );
        final materialApp = MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: state.theme,
          debugShowCheckedModeBanner: false,
        );
        final app = platformIsIOS ? cupertinoApp : materialApp;
        return app;
      },
    );
  }
}
