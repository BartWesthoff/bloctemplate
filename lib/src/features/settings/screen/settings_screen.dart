import 'package:bloctemplate/src/features/settings/widgets/settings_section_widget.dart';
import 'package:bloctemplate/src/features/settings/widgets/settings_widgets_export.dart';
import 'package:bloctemplate/src/features/theme/theme.dart';
import 'package:bloctemplate/src/widgets/theme_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SettingsSection(
                sectionTitle: "Appearance",
                widgets: [
                  SettingsTile(
                    leading: Icons.wb_sunny,
                    title: "Dark mode",
                    trailing: const ThemeSwitch(),
                    onTap: () => context.read<ThemeBloc>().add(
                          ThemeChanged(
                            themeNumber:
                                context.read<ThemeBloc>().state.themeNumber == 0
                                    ? 1
                                    : 0,
                          ),
                        ),
                  ),
                ],
              ),
              SettingsSection(
                sectionTitle: "Personal information",
                widgets: [
                  SettingsTile(
                    leading: Icons.mail,
                    title: "Email",
                    onTap: () => {},
                  ),
                  SettingsTile(
                    leading: Icons.lock,
                    title: "Password",
                    onTap: () => {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
