import 'package:bloctemplate/app/widgets/theme_switch_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(),
          const ThemeSwitch(),
        ],
      ),
    );
  }
}
