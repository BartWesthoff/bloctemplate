import 'package:bloctemplate/src/features/auth/bloc/auth_bloc.dart';
import 'package:bloctemplate/src/features/login/bloc/login_bloc.dart';
import 'package:bloctemplate/src/features/login/widgets/widgets.dart';
import 'package:firebase_auth_repository/firebase_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status.isSubmissionInProgress) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ?? 'Auth Failure',
                      ),
                    ),
                  );
              }
            },
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4),
                        ),
                        child: const Text("logo"),
                      ),
                      const SizedBox(height: 64),
                      EmailInput(),
                      const SizedBox(height: 8),
                      PasswordInput(),
                      const SizedBox(height: 8),
                      LoginButton(),
                      const SizedBox(height: 8),
                      //TODO make it better
                      GoogleLoginButton(),
                      const SizedBox(height: 4),
                      SignUpButton(),
                      const SizedBox(height: 4),
                      const SizedBox(height: 60),
                      Text(
                        context
                            .read<AuthBloc>()
                            .state
                            .status
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
