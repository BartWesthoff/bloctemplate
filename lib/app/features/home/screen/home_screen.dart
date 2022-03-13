import 'package:bloctemplate/app/features/authentication/bloc/authentication_bloc.dart';
import 'package:bloctemplate/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
                context.go(Routes.intro);
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
