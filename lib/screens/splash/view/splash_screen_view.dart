import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_restart.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/screens/splash/bloc/splash_screen_bloc.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/encryption.dart';
import '../../../main.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({Key? key}) : super(key: key);
  bool isLoading = true;
  SplashScreenModel? splashScreenModel;
  SplashScreenBloc? splashScreenBloc;

  @override
  Widget build(BuildContext context) {
    splashScreenBloc = context.read<SplashScreenBloc>();
    splashScreenBloc?.add(SplashScreenDataFetchEvent());
    return BlocBuilder<SplashScreenBloc, SplashScreenState>(
      builder: (BuildContext context, state) {
        if (state is SplashScreenInitial) {
          isLoading = true;
        } else if (state is SplashScreenSuccess) {
          isLoading = false;
          splashScreenModel = state.splashScreenModel;
          setApplicationData(context);
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AppSharedPref().getIfLogin() ?? false
                ? Navigator.pushReplacementNamed(context, navBar)
                : splashScreenModel?.allowGuestCheckout ?? false
                    ? Navigator.pushReplacementNamed(context, loginSignup,
                        arguments: true)
                    : Navigator.pushReplacementNamed(context, loginSignup,
                        arguments: true);
          });
        } else if (state is SplashScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? '', context);
          });
        }
        return buildUI(context);
      },
    );
  }

  Widget buildUI(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: AppSizes.width.toDouble(),
          height: AppSizes.height.toDouble(),
          child: Container(child:
          Image.asset(
              "lib/assets/images/splash.png",
              fit: BoxFit.fill,),
            decoration:  const BoxDecoration(color: AppColors.white),
          ),
        ),
        Positioned(
          bottom: AppSizes.height * 0.1,
          left: 0,
          right: 0,
          child: Visibility(visible: isLoading, child: Loader()),
        )
      ],
    );
  }

  void setApplicationData(BuildContext context) {
    AppSharedPref().setSplashData(splashScreenModel);
    if(AppSharedPref().getAppLanguage() == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (AppSharedPref().getAppLanguage() == null &&
            (splashScreenModel?.defaultLanguage?.length ?? 0) > 0) {
          AppSharedPref()
              .setAppLanguage(splashScreenModel?.defaultLanguage?[0] ?? "en");
        }
        if(MyApp.themeNotifier.value == ThemeMode.dark){
          MyApp.themeNotifier.value = ThemeMode.light;
        }
        else {
          AppSharedPref()
              .setAppLanguage(splashScreenModel?.defaultLanguage?[0] ?? "en");
          AppSharedPref().setFirstLang(true);
          MyApp.themeNotifier.value = ThemeMode.dark;
        }
      });
    }
    else{
      if (AppSharedPref().getAppLanguage() == null &&
          (splashScreenModel?.defaultLanguage?.length ?? 0) > 0) {
        AppSharedPref()
            .setAppLanguage(splashScreenModel?.defaultLanguage?[0] ?? "en");
      }
    }
  }


}
