import 'package:bloctemplate/src/features/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch(
          // activeColor: Theme.of(context).colorScheme.primary,
          trackColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
          thumbColor: MaterialStateProperty.all(Colors.white),
          value: state.themeNumber == 0,
          onChanged: (newValue) {
            context.read<ThemeBloc>().add(
                  ThemeChanged(
                    themeNumber:
                        context.read<ThemeBloc>().state.themeNumber == 0
                            ? 1
                            : 0,
                  ),
                );
          },
        );
      },
    );
  }
}
