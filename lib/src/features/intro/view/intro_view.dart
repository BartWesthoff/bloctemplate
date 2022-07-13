import 'package:bloctemplate/src/config/router/router.dart';
import 'package:bloctemplate/src/features/auth/bloc/auth_bloc.dart';
import 'package:bloctemplate/src/widgets/primary_action_button_widget.dart';
import 'package:bloctemplate/src/widgets/secondary_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                width: 200,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 4),
                ),
                child: const Text("logo"),
              ),
              const SizedBox(height: 88),
              const Text(
                "We play the music. You enjoy it. Deal?",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GothamMedium',
                ),
              ),
              Text(
                context.read<AuthBloc>().state.status.toString(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 88),
              PrimaryActionButton(
                text: "SIGN UP",
                onTap: () =>
                    //Navigation.instance.pushReplace(route: Routes.signUp),
                    context.push(Routes.signUp),
              ),
              const SizedBox(height: 16),
              SecondaryActionButton(
                text: "LOG IN",
                onTap: () => context.push(Routes.login),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48.0, right: 48, top: 48),
                child: Text(
                  "By clicking on Sign up, you agree to Spotify's Terms and Conditions of Use.",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
