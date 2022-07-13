import 'package:bloctemplate/src/features/login/bloc/login_bloc.dart';
import 'package:bloctemplate/src/widgets/primary_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : PrimaryActionButton(
                text: "Log In",
                onTap: () => state.status.isValidated
                    ? () =>
                        context.read<LoginBloc>().add(const LoginWithGoogle())
                    : null,
              );
      },
    );
  }
}
