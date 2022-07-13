import 'package:bloctemplate/src/features/root/bloc/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          fixedColor: Colors.white,
          currentIndex: state.index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Feature1',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Feature2',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Feature3',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<NavBarCubit>(context)
                  .getNavBarItem(NavbarItem.feature1);
            } else if (index == 1) {
              BlocProvider.of<NavBarCubit>(context)
                  .getNavBarItem(NavbarItem.feature2);
            } else if (index == 2) {
              BlocProvider.of<NavBarCubit>(context)
                  .getNavBarItem(NavbarItem.feature3);
            }
          },
        );
      },
    );
  }
}
