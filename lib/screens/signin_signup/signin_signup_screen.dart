// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';

class SignInSignUpScreen extends StatefulWidget {
  bool fromsplash = false;

  SignInSignUpScreen(this.fromsplash, {Key? key}) : super(key: key);

  @override
  _SignInSignUpScreenState createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  AppLocalizations? _localizations;
  SigninSignupScreenBloc? bloc;
  late bool _loading;
  SplashScreenModel? model;

  @override
  void initState() {
    AnalyticsEventsFirebase().screenView("SigninSignupScreen", "SigninSignupScreen");
    bloc = context.read<SigninSignupScreenBloc>();
    _loading = false;
    model = AppSharedPref().getSplashData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
        builder: (context, state) {
      print(state);
      if (state is LoadingState) {
        _loading = true;
      } else if (state is SigninSignupScreenError) {
        _loading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(state.message ?? "", context);
        });
      } else if (state is SignupScreenFormSuccess) {
        _loading = false;
        SignUpScreenModel model = state.data;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showSuccess(model.message ?? "", context);
          AppSharedPref().setIfLogin(model.success);
          Navigator.pushNamedAndRemoveUntil(context, navBar, (route) => false);
        });
      } else if (state is SigninSignupScreenError) {
        _loading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showSuccess(state.message ?? "", context);
        });
      }
      return Stack(
        children: <Widget>[
          _buildUI(),
          Visibility(
            child: Loader(),
            visible: _loading,
          ),
        ],
      );
    });
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: commonAppBar(
          _localizations?.translate(
                AppStringConstant.signInOrRegister,
              ) ??
              '',
          context,
          isLeadingEnable: model?.allowGuestCheckout ?? false ? true : false,
          onPressed: () {
        widget.fromsplash
            ? Navigator.pushNamedAndRemoveUntil(
                context, navBar, (route) => false)
            : Navigator.pop(context);
      }),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  _localizations?.translate(AppStringConstant.APPNAME) ??
                      "",
            textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
              child: Text(
                ((_localizations
                            ?.translate(AppStringConstant.signInOrRegister) ??
                        "")
                    .toUpperCase()),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 12),
              ),
            ),
            commonButton(
              context,
              () {
                signInSignUpBottomModalSheet(context, false);
              },
              _localizations
                      ?.translate(AppStringConstant.signInWithEmail)
                      .toUpperCase() ??
                  "",
            ),
            SizedBox(height: AppSizes.extraPadding),
            model?.allowSignup ?? true
                ? commonButton(
                    context,
                    () {
                      signInSignUpBottomModalSheet(context, true);
                    },
                    _localizations
                            ?.translate(AppStringConstant.createAnAccount)
                            .toUpperCase() ??
                        "",
                  )
                : Container(),
            SizedBox(height: AppSizes.extraPadding),
          ],
        )),
      ),
    );
  }
}
