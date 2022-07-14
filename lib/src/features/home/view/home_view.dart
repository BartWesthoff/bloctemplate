import 'package:bloctemplate/src/config/notifications/local/local_notifications.dart';
import 'package:bloctemplate/src/config/router/router.dart';
import 'package:bloctemplate/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Feature1View extends StatefulWidget {
  const Feature1View({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: Feature1View());

  @override
  State<Feature1View> createState() => _Feature1ViewState();
}

class _Feature1ViewState extends State<Feature1View> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.requestPermissions();
    LocalNotificationService.handleNotification(context);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                context
                    .read<AuthBloc>()
                    .add(AuthLogoutRequested());
                context.go(Routes.welcome);
              },
              child: const Text("hi"),
            ),
          ),
          Text(
            context.read<AuthBloc>().state.status.toString(),
            style:
                Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
