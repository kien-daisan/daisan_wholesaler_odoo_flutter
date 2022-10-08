import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/bottomNavigationBar/bloc/nav_bar_cubit.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_repository.dart';
import 'package:flutter_project_structure/screens/cart/cart_screen.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_bloc.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_repository.dart';
import 'package:flutter_project_structure/screens/category/category_screen.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_repository.dart';
import 'package:flutter_project_structure/screens/home/home_screen.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_repository.dart';
import 'package:flutter_project_structure/screens/profile/profile_screen.dart';
import '../../../helper/app_shared_pref.dart';


class NavBarView extends StatefulWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  AppLocalizations? _localizations;
  int selectedPage = 0;
  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.darkGray,
          selectedItemColor: Theme.of(context).bottomAppBarTheme.color,
          showSelectedLabels: true,
          currentIndex: state.index,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _localizations?.translate(AppStringConstant.home),
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.category_outlined),
                label: _localizations?.translate(AppStringConstant.categories)),
            BottomNavigationBarItem(
              icon: _cartButtonValue(),
              label: _localizations?.translate(AppStringConstant.cart),
            ),
            BottomNavigationBarItem(
                icon:  Stack(
                  children: [
                    const Icon(Icons.person_outlined),
                    if((AppSharedPref().getSplashData()?.addons?.odooGdpr ?? false) && !(AppSharedPref().getUserData()?.isEmailVerified ?? true))
                      const Positioned(
                        right: 0,
                          top: -8,
                          child: Text('!', style: TextStyle(color: AppColors.red, fontSize: 18),))
                  ],
                ),
                label: _localizations?.translate(AppStringConstant.profile))
          ],
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItems.home);
            } else if (index == 1) {
              // if(homeScreen?.getData()!=null){
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItems.categories);
              // }
            } else if (index == 2) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItems.cart);
              // setState(() {
              //   if (AppSharedPref().getIfLogin() == true) {
              //     UserDataModel? model = AppSharedPref().getUserData();
              //     cartCount = model?.cartCount ?? 0;
              //   }
              // });
            } else if (index == 3) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItems.profile);
            }
          },
        );
      }),
      body: WillPopScope(
        onWillPop: () async{
          print("selectedPage${selectedPage}");
          if(selectedPage != 0){
            BlocProvider.of<NavigationCubit>(context)
                .getNavBarItem(NavbarItems.home);
            return false;
          }
         return true;
        },
        child: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          if (state.item == NavbarItems.home) {
            selectedPage = 0;
            return MultiBlocProvider(
              providers: [
                BlocProvider<HomeScreenBloc>(
                    create: (context) =>
                        HomeScreenBloc(repository: HomeScreenRepositoryImp())),

              ],
              child: HomeScreen(),
            );
          } else if (state.item == NavbarItems.categories) {
            selectedPage = 1;
            return BlocProvider(
              create: (context) =>
                  CategoryScreenBloc(CategoryScreenRepositoryImp()),
              child: CategoryScreen(),
            );
          } else if (state.item == NavbarItems.cart) {
            selectedPage = 2;
            return  BlocProvider(
              create: (context) =>
                  CartScreenBloc(repository: CartScreenRepositoryImp()),
              child: const CartScreen(),
            );
          } else if (state.item == NavbarItems.profile) {
            selectedPage = 3;
            return BlocProvider(
              create: (context) =>
                  ProfileScreenBloc(repository: ProfileScreenRepositoryImp()),
              child: const ProfileScreen(),
            );
          }
          return Container();
        }),
      ),
    );
  }

  _cartButtonValue() {
    return BadgeIcon(
      icon: const Icon(Icons.shopping_cart),
      badgeColor: Colors.red,
    );
  }

}
