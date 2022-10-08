part of 'nav_bar_cubit.dart';


class NavigationState extends Equatable{
  final NavbarItems? item;
  int index;

  NavigationState(this.index,this.item);

  @override
  // TODO: implement props
  List<Object?> get props => [this.item,this.index];

}