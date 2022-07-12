import 'package:bloctemplate/src/features/home/screen/home_screen.dart';
import 'package:bloctemplate/src/features/root/bloc/nav_bar_cubit.dart';
import 'package:bloctemplate/src/features/search/screen/search_screen.dart';
import 'package:bloctemplate/src/features/settings/screen/settings_screen.dart';
import 'package:bloctemplate/src/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     DynamicLinkService.instance.initDynamicLinks();
//   }
//
//
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          if (state.navbarItem == NavbarItem.feature1) {
            return const Feature1Screen();
          } else if (state.navbarItem == NavbarItem.feature2) {
            return const Feature2Screen();
          } else if (state.navbarItem == NavbarItem.feature3) {
            return const Feature3Screen();
          }
          return Container();
        },
      ),
    );
  }
}
