import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required this.leading,
    required this.title,
    required this.onTap,
    this.trailing,
  }) : super(key: key);

  final IconData leading;
  final String title;
  final Widget? trailing;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          enableFeedback: true,
          trailing: trailing ??
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(
            leading,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
