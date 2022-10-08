import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_switch_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/utils/helper.dart';

class CreateAnAccount extends StatefulWidget {
  const CreateAnAccount({Key? key}) : super(key: key);

  @override
  _CreateAnAccountState createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  SigninSignupScreenBloc? bloc;
  late TextEditingController _emailController,
      _passwordController,
      _nameController,
      _confirmPasswordController;
  late AppLocalizations? _localizations;
  late bool _loading;
  bool agreeOnTerms = false;
  CountryListModel? _countryListModel;
  late GlobalKey<FormState> _formKey;


  void _validateForm() async {
    if ((AppSharedPref().getSplashData()?.termsAndConditions ?? false) && !agreeOnTerms) {
      AlertMessage.showError(
          _localizations?.translate(AppStringConstant.acceptTermAndCondition) ??
              "",
          context);

    } else {
      if (_formKey.currentState?.validate() == true) {
        Helper.hideSoftKeyBoard();
        bloc?.add(SignUpEvent(_emailController.text.trim(),
            _passwordController.text, _nameController.text));
        bloc?.emit(LoadingState());
      }
    }
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
    _loading = false;
    _formKey = GlobalKey();
    bloc = context.read<SigninSignupScreenBloc>();
    bloc?.add(const SignUpInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
      builder: (context, state) {
        print(state);
        if (state is LoadingState) {
          _loading = true;
        } else if (state is SignUpInitialDataState) {
          _loading = false;
          _countryListModel = state.model;
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        } else if (state is SignupScreenFormSuccess) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(model.message ?? "", context);
            AppSharedPref().setIfLogin(model.success);
            AppSharedPref().setUserData(UserDataModel(
                cartCount: model.login?.cartCount,
                name: model.login?.customerName,
                email: model.login?.customerEmail,
                bannerImage: model.login?.customerBannerImage,
                profileImage: model.login?.customerProfileImage,
                customerId: model.login?.customerId,
                isSeller: model.login?.isSeller,
                isEmailVerified: model.login?.isEmailVerified));
            AnalyticsEventsFirebase().signUpEvent(state.data.toString());
            Navigator.pushNamedAndRemoveUntil(
                context, navBar, (route) => false);
          });
        } else if (state is SignUpTermSuccessState) {
          _loading = false;
          Future.delayed(Duration.zero, () {
            DialogHelper.signUpTerms(
                (state.data.termsAndConditions != null)
                    ? (state.data.termsAndConditions ?? '')
                    : (state.data.sellerTermsAndConditions ?? ''),
                context);
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
          _localizations?.translate(AppStringConstant.createAnAccount) ?? "",
          context,
          isLeadingEnable: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.imageRadius),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: AppSizes.normalPadding,
                ),
                CommonTextField(
                  controller: _emailController,
                  isPassword: false,
                  hintText: _localizations
                          ?.translate(AppStringConstant.emailAddress) ??
                      "",
                  isRequired: true,
                  inputType: TextInputType.emailAddress,
                  validationType: AppStringConstant.email,
                ),

                const SizedBox(height: AppSizes.extraPadding),
                CommonTextField(
                  controller: _nameController,
                  isRequired: true,
                  isPassword: false,
                  hintText:
                      _localizations?.translate(AppStringConstant.name) ?? '',
                  inputType: TextInputType.name,
                ),

                const SizedBox(height: AppSizes.extraPadding),

                CommonTextField(
                  hintText:
                      _localizations?.translate(AppStringConstant.password) ??
                          "",
                  controller: _passwordController,
                  isRequired: true,
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  validationType: AppStringConstant.password,
                ),
                const SizedBox(height: AppSizes.extraPadding),
                CommonTextField(
                  hintText: _localizations
                          ?.translate(AppStringConstant.confirmPassword) ??
                      "",
                  controller: _confirmPasswordController,
                  isRequired: true,
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  validation: (value) {
                    if (_confirmPasswordController.text.isEmpty) {
                      return "${AppLocalizations.of(context)?.translate(AppStringConstant.required)}";
                    } else if (_confirmPasswordController.text !=
                        _passwordController.text) {
                      return _localizations
                              ?.translate(AppStringConstant.passwordNotMatch) ??
                          '';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.extraPadding),
                Visibility(
                  visible: AppSharedPref().getSplashData()?.termsAndConditions ?? false,
                  child: CommonSwitchButton(
                      _localizations?.translate(
                              AppStringConstant.agreeTermAndCondition) ??
                          '', (value) {
                    setState(() {
                      agreeOnTerms = value;
                    });
                  }, agreeOnTerms),
                ),
                Visibility(
                  visible: AppSharedPref().getSplashData()?.termsAndConditions ?? false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            bloc?.add(const SignUpTermsEvent());
                          },
                          child: Text(
                              (_localizations
                                      ?.translate(AppStringConstant.viewTerms) ??
                                  ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: AppColors.textBlue))),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.normalPadding),

                /// Signup
                commonButton(
                    context,
                    _validateForm,
                    (_localizations?.translate(
                                AppStringConstant.createAnAccount) ??
                            "")
                        .toUpperCase(),
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor:
                        Theme.of(context).colorScheme.secondaryContainer),
                const SizedBox(height: AppSizes.extraPadding),

                /// Loging
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        _localizations
                                ?.translate(AppStringConstant.alreadyAccount)
                                .toUpperCase() ??
                            '',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 13)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          signInSignUpBottomModalSheet(context, false);
                        },
                        child: Text(
                            (_localizations
                                        ?.translate(AppStringConstant.signIn) ??
                                    '')
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppColors.textBlue)))
                  ],
                ),

                const SizedBox(height: AppSizes.extraPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
