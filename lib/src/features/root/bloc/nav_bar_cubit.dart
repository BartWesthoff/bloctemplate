import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_bar_state.dart';

enum NavbarItem { feature1, feature2, feature3 }

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState(NavbarItem.feature1, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.feature1:
        emit(const NavBarState(NavbarItem.feature1, 0));
        break;
      case NavbarItem.feature2:
        emit(const NavBarState(NavbarItem.feature2, 1));
        break;
      case NavbarItem.feature3:
        emit(const NavBarState(NavbarItem.feature3, 2));
        break;
    }
  }
}
