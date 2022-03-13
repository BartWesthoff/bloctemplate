import 'package:bloctemplate/app/features/home/screen/home_screen.dart';
import 'package:bloctemplate/app/features/library/screen/library_screen.dart';
import 'package:bloctemplate/app/features/root/bloc/nav_bar_cubit.dart';
import 'package:bloctemplate/app/features/search/screen/search_screen.dart';
import 'package:bloctemplate/app/widgets/bottom_nav_bar_widget.dart';
import 'package:bloctemplate/utils/services/dynamic_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DynamicLinkService.instance.initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const BottomNavBar(),
      body: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          if (state.navbarItem == NavbarItem.home) {
            return const HomeScreen();
          } else if (state.navbarItem == NavbarItem.search) {
            return const SearchScreen();
          } else if (state.navbarItem == NavbarItem.library) {
            return const LibraryScreen();
          }
          return Container();
        },
      ),
    );
  }
}
