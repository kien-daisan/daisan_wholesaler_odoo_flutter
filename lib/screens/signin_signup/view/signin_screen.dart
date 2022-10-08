import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';

import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/utils/helper.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import '../../../helper/encryption.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SigninSignupScreenBloc? bloc;
  late TextEditingController _emailController, _passwordController;
  late AppLocalizations? _localizations;
  late bool _obscureText, _loading;
  late GlobalKey<FormState> _formKey;
  SplashScreenModel? model;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    model = AppSharedPref().getSplashData();
    bloc = context.read<SigninSignupScreenBloc>();
    _obscureText = true;
    _loading = false;
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Helper.hideSoftKeyBoard();
      bloc?.add(LoginEvent(_emailController.text.trim(), _passwordController.text));
      bloc?.emit(LoadingState());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
      builder: (context, state) {
        if (state is LoadingState) {
          _loading = true;
        } else if (state is ForgotPasswordState) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(model.message ?? "", context);
            Navigator.pushNamedAndRemoveUntil(
                context, navBar, (route) => false);
          });
        } else if (state is LoginState) {
          _loading = false;
          var model = state.data;
          AnalyticsEventsFirebase().loginEvent();
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            updateUserPreference(model);
            checkFingerprint();
            AlertMessage.showSuccess(model.message ?? "", context);
          });
        } else if (state is FingerprintLoginState) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            updateUserPreference(model);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(navBar, (route) => false);
            AlertMessage.showSuccess(model.message ?? "", context);
          });
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        }
        return Stack(
          children: <Widget>[
            _buildContent(),
            Visibility(
              child: Loader(),
              visible: _loading,
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: commonToolBar(
          (_localizations?.translate(AppStringConstant.signInWithEmail) ?? ""),
          context,
          isLeadingEnable: true),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.imageRadius, vertical: AppSizes.buttonRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonTextField(
                  controller: _emailController,
                  isRequired: true,
                  isPassword: false,
                  validationType: AppStringConstant.email,
                  inputType: TextInputType.emailAddress,
                  hintText: _localizations
                          ?.translate(AppStringConstant.emailAddress) ??
                      "",
                ),

                const SizedBox(height: AppSizes.extraPadding),
                CommonTextField(
                  // isPassword: true,
                  controller: _passwordController,
                  isRequired: true,
                  isPassword: true,
                  validationType: AppStringConstant.password,
                  hintText:
                      _localizations?.translate(AppStringConstant.password) ??
                          "",
                ),

                const SizedBox(height: AppSizes.extraPadding * 1.5),

                /// Forgot password
                GestureDetector(
                  child: Text(
                    _localizations
                            ?.translate(AppStringConstant.forgetPassword) ??
                        "",
                    style: const TextStyle(
                        color: AppColors.lightGray, fontSize: 13),
                  ),
                  onTap: () {
                    DialogHelper.forgotPasswordDialog(
                      context,
                      _localizations,
                      _localizations?.translate(
                              AppStringConstant.forgotPasswordTitle) ??
                          '',
                      _localizations?.translate(
                              AppStringConstant.forgotPasswordMessage) ??
                          '',
                      onConfirm: (email) {
                        bloc?.add(ForgotPasswordEvent(email));
                        bloc?.emit(LoadingState());
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSizes.extraPadding * 1.5),

                /// Signin

                commonButton(
                    context,
                    _validateForm,
                    (_localizations?.translate(AppStringConstant.signIn) ?? "")
                        .toUpperCase(),
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Theme.of(context).colorScheme.secondaryContainer),

                const SizedBox(height: AppSizes.extraPadding),

                /// Create account
                model?.allowSignup ?? true
                ? commonButton(
                  context,
                  () {
                    Navigator.pop(context);
                    signInSignUpBottomModalSheet(context, true);
                  },
                  (_localizations
                              ?.translate(AppStringConstant.createAnAccount) ??
                          "")
                      .toUpperCase(),
                )
                : Container(),

                const SizedBox(height: AppSizes.extraPadding),

                if (AppSharedPref().getFingerPrintData() != null)
                  Center(
                    child: InkWell(
                      child: Lottie.asset("lib/assets/lottie/finger_print.json",
                          width: AppSizes.width / 6,
                          height: AppSizes.width / 6,
                          fit: BoxFit.fill,
                          repeat: true),
                      onTap: () {
                        startAuthentication(false);
                      },
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //==========Update Session==========//
  void updateUserPreference(LoginResponseModel model) {
    AppSharedPref().setIfLogin(model.success);
    AppSharedPref().setUserData(UserDataModel(
        isEmailVerified: model.isEmailVerified,
        name: model.customerName,
        email: model.customerEmail,
        bannerImage: model.customerBannerImage,
        profileImage: model.customerProfileImage,
        cartCount: model.cartCount,
      customerId: model.customerId,
      isSeller: model.isSeller,
    ));
  }

  //================Handle Fingerprint Login==============//
  final LocalAuthentication auth = LocalAuthentication(); //----Initialization
  void checkFingerprint() {
    auth.isDeviceSupported().then((value) {
      if (value) {
        showFingerprintDialog();
      } else {
        print("Else Condition");
        Navigator.of(context).pushNamedAndRemoveUntil(navBar, (route) => false);
      }
    });
  }

  void showFingerprintDialog() async {
    DialogHelper.forgotPasswordDialog(
        context,
        _localizations,
        _localizations?.translate(AppStringConstant.fingerprintLogin)??"",
        _localizations?.translate(AppStringConstant.fingerprintLoginDialog)??"",
        onConfirm: (data) {
      startAuthentication(true);
    }, onCancel: (value) {
      Navigator.of(context).pushNamedAndRemoveUntil(navBar, (route) => false);
    }, isForgotPassword: false);
  }

  void startAuthentication(bool alreadyLogin) async {
    auth.isDeviceSupported().then((value) async {
      if (value) {
        bool didAuthenticate =
            await auth.authenticate(localizedReason: _localizations?.translate(AppStringConstant.fingerprintLogin) ?? '');
        if (didAuthenticate) {
          if (alreadyLogin) {
            Map<String, dynamic> header = {};
            header["login"] = _emailController.text;
            header["pwd"] = _passwordController.text;
            String key = generateEncodedApiKey(json.encode(header));
            AppSharedPref().setFingerPrintData(key);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(navBar, (route) => false);
          } else {
            bloc?.add(FingerprintLoginEvent(
                AppSharedPref().getFingerPrintData() ?? ""));
            bloc?.emit(LoadingState());
          }
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(_localizations?.translate(AppStringConstant.authenticationFailed) ?? '', context);
          });
        }
      } else {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(_localizations?.translate(AppStringConstant.authenticationUnable) ?? '', context);
        });
      }
    });
  }
}
