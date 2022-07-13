import 'package:bloctemplate/src/features/home/view/home_view.dart';
import 'package:bloctemplate/src/features/root/bloc/nav_bar_cubit.dart';
import 'package:bloctemplate/src/features/search/view/search_view.dart';
import 'package:bloctemplate/src/features/settings/view/settings_view.dart';
import 'package:bloctemplate/src/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeView extends StatefulWidget {
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

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          if (state.navbarItem == NavbarItem.feature1) {
            return const Feature1View();
          } else if (state.navbarItem == NavbarItem.feature2) {
            return const Feature2View();
          } else if (state.navbarItem == NavbarItem.feature3) {
            return const Feature3View();
          }
          return Container();
        },
      ),
    );
  }
}
