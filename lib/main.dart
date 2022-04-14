import 'package:bloc/bloc.dart';
import 'package:bloctemplate/app.dart';
import 'package:bloctemplate/bloc_observer.dart';
import 'package:firebase_auth_repository/firebase_authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  final authenticationRepository = AuthenticationRepository();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  BlocOverrides.runZoned(
    () => runApp(
      App(authenticationRepository: authenticationRepository),
    ),
    blocObserver: AuthBlocObserver(),
  );
}
