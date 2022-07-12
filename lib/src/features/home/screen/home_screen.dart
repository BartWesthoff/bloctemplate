import 'package:bloctemplate/src/config/routes/routes.dart';
import 'package:bloctemplate/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Feature1Screen extends StatefulWidget {
  const Feature1Screen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: Feature1Screen());

  @override
  State<Feature1Screen> createState() => _Feature1ScreenState();
}

class _Feature1ScreenState extends State<Feature1Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
                context.go(Routes.welcome);
              },
              child: const Text("hi"),
            ),
          ),
          Text(
            context.read<AuthenticationBloc>().state.status.toString(),
            style:
                Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
