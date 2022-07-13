import 'package:bloctemplate/src/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => context.push(Routes.signUp),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
