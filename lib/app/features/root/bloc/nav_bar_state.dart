part of 'nav_bar_cubit.dart';

class NavBarState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const NavBarState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
