import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_bloc.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_repository.dart';
import 'package:flutter_project_structure/screens/Notification/notification_screen.dart';
import 'package:flutter_project_structure/screens/addReview/add_review_screen.dart';
import 'package:flutter_project_structure/screens/addReview/bloc/add_review_screen_bloc.dart';
import 'package:flutter_project_structure/screens/addReview/bloc/add_review_screen_repository.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/bloc/checkout_screen_bloc.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/bloc/checkout_screen_repository.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/views/change_address_view.dart';
import 'package:flutter_project_structure/screens/locationScreen/bloc/location_bloc.dart';
import 'package:flutter_project_structure/screens/locationScreen/bloc/location_repository.dart';
import 'package:flutter_project_structure/screens/locationScreen/views/place_search.dart';
import 'package:flutter_project_structure/screens/profile/view/setting_bottomsheet.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_repository.dart';
import 'package:flutter_project_structure/screens/signin_signup/view/create_account_screen.dart';
import 'package:flutter_project_structure/screens/signin_signup/view/my_bottom_sheet.dart';
import 'package:flutter_project_structure/screens/signin_signup/view/signin_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/AddressListModel.dart';
import '../screens/checkoutScreen/shippingDetails/checkout_screen.dart';

void signInSignUpBottomModalSheet(
  BuildContext context,
  bool isSignUp,
) {
  showMyModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => BlocProvider(
        create: (context) => SigninSignupScreenBloc(
            repository: SigninSignupScreenRepositoryImp()),
        child: (isSignUp) ? const CreateAnAccount() : const SignInScreen()),
  );
}

void reviewBottomModalSheet(
    BuildContext context, String productName, String thumbNail, int templateId,
    {Function? function}) {
  showMyModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) =>
                AddReviewScreenBloc(repository: AddReviewRepositoryImp()),
            child: AddReviewScreen(productName, thumbNail, templateId),
          )).then((value) {
    if (value == true && function != null) {
      function();
    }
  });
}

void notificationBottomModelSheet(BuildContext context) {
  showMyModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) =>
                NotificationBloc(repository: NotificationRepositoryImp()),
            child: const NotificationScreen(),
          ));
}

void shippingAddressModelBottomSheet(
    BuildContext context, Function(int) onTap, AddressListModel? addresses) {
  showMyModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
            height:
                AppSizes.height - WidgetsBinding.instance!.window.padding.top,
            child: ShowAddressList(onTap, addresses),
          ));
}

void showSettingBottomSheet(BuildContext context) {
  showMyModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const SettingsBottomSheet());
}

void placeSearchBottomModelSheet(
    BuildContext context, Function(LatLng) callback) {
  showMyModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) => BlocProvider(
            create: (context) =>
                LocationScreenBloc(repository: LocationRepositoryImp()),
            child: const PlaceSearch(),
          )).then((value) {
    if (value is LatLng) {
      callback(value);
    }
  });
}
