import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/screens/accountInfo/account_info_screen.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_bloc.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_repository.dart';
import 'package:flutter_project_structure/screens/addEditAddress/add_edit_address_screen.dart';
import 'package:flutter_project_structure/screens/addEditAddress/bloc/add_edit__address_repository.dart';
import 'package:flutter_project_structure/screens/addEditAddress/bloc/add_edit_address_screen_bloc.dart';
import 'package:flutter_project_structure/screens/addressBook/address_book.dart';
import 'package:flutter_project_structure/screens/addressBook/bloc/addressbook_screen_bloc.dart';
import 'package:flutter_project_structure/screens/addressBook/bloc/addressbook_screen_repository.dart';
import 'package:flutter_project_structure/screens/bottomNavigationBar/bloc/nav_bar_cubit.dart';
import 'package:flutter_project_structure/screens/bottomNavigationBar/views/nav_bar_view.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_repository.dart';
import 'package:flutter_project_structure/screens/cart/cart_screen.dart';
import 'package:flutter_project_structure/screens/catalog/bloc/catalog_screen_bloc.dart';
import 'package:flutter_project_structure/screens/catalog/bloc/catalog_screen_repository.dart';
import 'package:flutter_project_structure/screens/catalog/catalog_screen.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/checkout_screen.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_repository.dart';
import 'package:flutter_project_structure/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_repository.dart';
import 'package:flutter_project_structure/screens/home/home_screen.dart';
import 'package:flutter_project_structure/screens/locationScreen/location_screen.dart';
import 'package:flutter_project_structure/screens/orderDetail/bloc/order_detail_screen_bloc.dart';
import 'package:flutter_project_structure/screens/orderDetail/bloc/order_detail_screen_repository.dart';
import 'package:flutter_project_structure/screens/orderDetail/order_detail_screen.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_bloc.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_repository.dart';
import 'package:flutter_project_structure/screens/orders/orders_screen.dart';
import 'package:flutter_project_structure/screens/product/bloc/review_screen_bloc.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_bloc.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_repository.dart';
import 'package:flutter_project_structure/screens/search/search_screen.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_repository.dart';
import 'package:flutter_project_structure/screens/signin_signup/signin_signup_screen.dart';
import 'package:flutter_project_structure/screens/splash/bloc/splash_screen_repository.dart';
import 'package:flutter_project_structure/screens/splash/view/splash_screen_view.dart';
import 'package:flutter_project_structure/screens/splash/bloc/splash_screen_bloc.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategory_screen_repository.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategroy_screen_bloc.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/sub_category_screen.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_repository.dart';
import 'package:flutter_project_structure/screens/wishlist/wishlist_screen.dart';
import '../screens/checkoutScreen/shippingDetails/bloc/checkout_screen_repository.dart';
import '../screens/checkoutScreen/reviewPayments/bloc/review_screen_bloc.dart';
import '../screens/checkoutScreen/reviewPayments/bloc/review_screen_repository.dart';
import '../screens/checkoutScreen/reviewPayments/review&payments.dart';
import '../screens/checkoutScreen/shippingDetails/bloc/checkout_screen_bloc.dart';
import '../screens/product/bloc/product_screen_bloc.dart';
import '../screens/product/bloc/product_screen_repository.dart';
import '../screens/product/product_screen.dart';
import '../screens/product/views/product_reviews.dart';
import '../screens/search/views/camera_search_screen.dart';

Route<dynamic> generateRouteSettings(RouteSettings route) {
  final args = route.arguments;
  switch (route.name) {
    case home:
      return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
                BlocProvider<HomeScreenBloc>(
                    create: (context) =>
                        HomeScreenBloc(repository: HomeScreenRepositoryImp())),
                BlocProvider<NavigationCubit>(
                    create: (context) => NavigationCubit()),
              ], child: HomeScreen()));
    case navBar:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<NavigationCubit>(
                create: (context) => NavigationCubit(),
                child: const NavBarView(),
              ));
    case splash:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashScreenBloc>(
                create: (context) => SplashScreenBloc(
                    splashScreenRepository: SplashscreenRepositoryImp()),
                child: SplashScreenView(),
              ));
    case catalogPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<CatalogScreenBloc>(
                create: (context) => CatalogScreenBloc(
                    repository: CategoryScreenRepositoryImp()),
                child: CatalogScreen(route.arguments as Map<String, dynamic>),
              ));
    case subCategory:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<SubcategoryBloc>(
              create: (context) =>
                  SubcategoryBloc(repository: SubCategoryRepositoryImp()),
              child:
                  SubCategoryScreen(route.arguments as Map<String, dynamic>)));
    case productPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductScreenBloc>(
              create: (context) =>
                  ProductScreenBloc(repository: ProductScreenRepositoryImp()),
              child: ProductScreen(route.arguments as Map<String, dynamic>)));
    case reviewList:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<ReviewScreenBloc>(
              create: (context) =>
                  ReviewScreenBloc(repository: ProductScreenRepositoryImp()),
              child: ProductReview(
                productDetails: route.arguments as Map<String, dynamic>,
              )));
    case cart:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<CartScreenBloc>(
              create: (context) =>
                  CartScreenBloc(repository: CartScreenRepositoryImp()),
              child: const CartScreen()));
    case loginSignup:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => SigninSignupScreenBloc(
                  repository: SigninSignupScreenRepositoryImp()),
              child: SignInSignUpScreen(args as bool)));
    case addEditAddress:
      String? endpoint;
      if (args != null) {
        endpoint = args.toString();
      }
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => AddEditAddressScreenBloc(
                  repository: AddEditAddressRepositoryImp()),
              child: AddEditAddress(
                addressEndpoint: endpoint,
              )));
    case addressBook:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  AddressBookScreenBloc(repository: AddressBookRepositoryImp()),
              child: AddressBook()));
    case checkoutPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  CheckoutScreenBloc(repository: CheckoutScreenRepositoryImp()),
              child: CheckoutScreen(args.toString())));
    case paymentReviewPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => PaymentReviewScreenBloc(
                  repository: PaymentReviewScreenRepositoryImp()),
              child: ReviewScreen(args as Map<String, dynamic>)));
    case orders:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  OrderScreenBloc(repository: OrderScreenRepositoryImp()),
              child: OrderScreen(args as bool)));
    case orderDetails:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  OrderDetailsBloc(repository: OrderDetailRepositoryImp()),
              child: OrderDetails(args as String)));
    case wishlist:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  WishlistScreenBloc(repository: WishlistImpRepository()),
              child: const WishlistScreen()));
    case accountInfo:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  AccountInfoBloc(repository: AccountInfoRepositoryImp()),
              child: const AccountInfoScreen()));
    case dashboard:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  DashboardBloc(repository: DashboardRepositoryImp()),
              child: const DashboardScreen()));
    case searchPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  SearchScreenBloc(repository: SearchRepositoryImp()),
              child: const SearchScreen()));
    case cameraSearch:
      return MaterialPageRoute(
          builder: (_) => CameraSearch(searchType: args.toString()));

    case location:
      return MaterialPageRoute(builder: (_) => const LocationScreen());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${route.name}')),
              ));
  }
}
