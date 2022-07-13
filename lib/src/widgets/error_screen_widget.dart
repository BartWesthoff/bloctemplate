import 'package:bloctemplate/src/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My "Page Not Found" Screen')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SelectableText(error.toString()),
              TextButton(
                onPressed: () => context.go(Routes.login),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      );
}
