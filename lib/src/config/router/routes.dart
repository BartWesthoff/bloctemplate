import 'package:bloctemplate/src/features/home/view/home_view.dart';
import 'package:bloctemplate/src/features/intro/view/intro_view.dart';
import 'package:bloctemplate/src/features/login/view/sign_in_view.dart';
import 'package:bloctemplate/src/features/root/view/root_view.dart';
import 'package:bloctemplate/src/features/search/view/search_view.dart';
import 'package:bloctemplate/src/features/settings/view/settings_view.dart';
import 'package:bloctemplate/src/features/sign_up/view/sign_up_view.dart';
import 'package:flutter/material.dart';
enum Routes {
  welcome(IntroView()),
  login(SignInView()),
  signUp(SignUpView()),
  feature1(Feature1View()),
  feature2(Feature2View()),
  feature3(Feature3View()),
  home(HomeView());

  const Routes(this.routeView);

  final Widget routeView;

  @override
  String toString() => '$name: [$routePath][$routeName][$routeView]';

  String get routeName => routePath.split('/').last.toUpperCase();

  String get routePath => "/$name";
}
