import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloctemplate/app/features/sign_up/sign_up.dart';
import 'package:bloctemplate/app/features/sign_up/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status.isSubmissionSuccess) {
                Navigator.of(context).pop();
              } else if (state.status.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'Sign Up Failure'),
                    ),
                  );
              }
            },
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmailInput(),
                  const SizedBox(height: 8),
                  PasswordInput(),
                  const SizedBox(height: 8),
                  ConfirmPasswordInput(),
                  const SizedBox(height: 8),
                  SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
