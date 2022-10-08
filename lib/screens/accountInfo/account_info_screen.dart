import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_switch_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_bloc.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_events.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_state.dart';
import 'package:flutter_project_structure/screens/accountInfo/views/deactivate_account.dart';

import '../../helper/app_restart.dart';
import 'views/email_verification.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool changePassword = false;
  bool isLoading = false;
  bool isEmailVerified = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AppLocalizations? _localizations;
  AccountInfoModel? accountInfo;
  AccountInfoBloc? _accountInfoBloc;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    UserDataModel? userData = AppSharedPref().getUserData();
    nameController.text = userData?.name ?? "";
    emailController.text = userData?.email ?? "";
    isEmailVerified = userData?.isEmailVerified ?? false;
    _accountInfoBloc = context.read<AccountInfoBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(
        builder: (BuildContext context, AccountInfoState currentState) {
          if (currentState is AccountInfoLoadingState) {
            isLoading = true;
          } else if (currentState is AccountInfoSuccessState) {
            isLoading = false;
            accountInfo = currentState.data;
            if (currentState.data.success ?? false) {
              var data = AppSharedPref().getUserData();
              data?.name = nameController.text;
              AppSharedPref().setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.data.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.data.message ?? '', context);
              });
            }
          } else if (currentState is AccountInfoDeactivateState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (currentState.data.success ?? false) {
                AlertMessage.showSuccess(
                    currentState.data.message ?? '', context);
                AppSharedPref().logoutUser();
                Navigator.pushNamedAndRemoveUntil(
                    context, splash, (route) => false);
              } else {
                AlertMessage.showError(
                    currentState.data.message ?? "", context);
              }
            });
          } else if (currentState is AccountInfoErrorState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message, context);
            });
          } else if (currentState is AccountInfoDownloadSuccessState) {
            isLoading = false;
            accountInfo = currentState.data;
          }
          else if (currentState is DeleteLoginSuccessState) {
            var data = currentState.data;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (data.success == true) {
                _accountInfoBloc?.add(const DeleteAccountEvent());
              } else {
                isLoading = false;
                AlertMessage.showError(
                    _localizations?.translate(
                        AppStringConstant.invalidPassword) ??
                        '',
                    context);
              }
            });
          } else if (currentState is DeleteAccountSuccess) {
            var data = currentState.data;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (data.success == true) {
                AlertMessage.showSuccess(
                    currentState.data.message ?? "", context);
                AppSharedPref().logoutUser();
                AppRestart.rebirth(context);
              } else {
                AlertMessage.showError(
                    currentState.data.message ?? "", context);
              }
            });
          } else if (currentState is ResendVerificationSuccessState) {
            isLoading = false;
            if (currentState.data.success ?? false) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.data.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.data.message ?? '', context);
              });
            }
          }

          return _buildUI();
        });
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: commonAppBar(
          _localizations?.translate(AppStringConstant.accountInfo) ?? '',
          context),
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: Stack(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    accountInfoForm(),
                    deactivateAccount(context, _localizations, () {
                      DialogHelper.confirmationDialog(
                          AppStringConstant.deactivateTemporaryDialog,
                          context,
                          _localizations, onConfirm: () {
                        _accountInfoBloc?.add(const DeactivateAccount(
                            AppConstant.deactivateTemporary));
                      });
                    }, () {
                      DialogHelper.confirmationDialog(
                          AppStringConstant.deactivatePermanentDialog,
                          context,
                          _localizations, onConfirm: () {
                        _accountInfoBloc?.add(const DeactivateAccount(
                            AppConstant.deactivatePermanent));
                      });
                    }),
                    downloadInfo(),
                    if((AppSharedPref()
                        .getSplashData()
                        ?.addons
                        ?.odooGdpr ?? false) && !(AppSharedPref()
                        .getUserData()
                        ?.isEmailVerified ?? true))
                      verificationContainer(
                          context, _localizations, emailController, () {
                        _accountInfoBloc?.add(const ReSendVerificationEvent());
                      })
                  ],
                ),
              ),
              Visibility(visible: isLoading, child: Loader())
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.genericPadding,
                vertical: AppSizes.imageRadius),
            child: commonButton(context, () {
              if (AppSharedPref()
                  .getUserData()
                  ?.email !=
                  AppConstant.demoEmail) {
                DialogHelper.confirmationDialog(
                    _localizations
                        ?.translate(AppStringConstant.deleteAccountAlert) ??
                        '',
                    context,
                    _localizations, onConfirm: () {
                  DialogHelper.deleteAccountConfirmationDialog(
                      context,
                      _localizations
                          ?.translate(AppStringConstant.deleteAccount) ??
                          "",
                      "${_localizations?.translate(AppStringConstant
                          .deleteAccountWarningStartMessage)} ${AppSharedPref()
                          .getUserData()
                          ?.email} ${_localizations?.translate(
                          AppStringConstant.deleteAccountWarningEndMessage)}",
                          (p0) {
                        _accountInfoBloc?.add(DeleteAccountLoginEvent(
                            AppSharedPref()
                                .getUserData()
                                ?.email ?? "", p0));
                      }, _localizations);
                });
              } else {
                DialogHelper.showExceptionDialog(
                    _localizations
                        ?.translate(AppStringConstant.dontHavePermission) ??
                        "",
                    context,
                    buttonText:
                    _localizations?.translate(AppStringConstant.ok));
              }
            }, _localizations?.translate(AppStringConstant.deleteAccount) ?? '',
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .onPrimary,
                textColor: Theme
                    .of(context)
                    .colorScheme
                    .secondaryContainer),
          )
        ],
      ),
    );
  }

  Widget accountInfoForm() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(AppSizes.extraPadding),
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
                    controller: nameController,
                    isPassword: false,
                    hintText:
                    _localizations?.translate(AppStringConstant.yourName) ??
                        "",
                    isRequired: true,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(height: AppSizes.normalPadding),
                  CommonSwitchButton(
                      _localizations
                          ?.translate(AppStringConstant.changePassword) ??
                          '', (value) {
                    setState(() {
                      changePassword = value;
                      passwordController.clear();
                      confirmPasswordController.clear();
                    });
                  }, changePassword, colors: Theme
                      .of(context)
                      .cardColor),
                  const SizedBox(height: AppSizes.normalPadding),
                  if (changePassword)
                    Column(
                      children: [
                        CommonTextField(
                          controller: passwordController,
                          isRequired: changePassword,
                          isPassword: true,
                          validationType: AppStringConstant.password,
                          hintText: _localizations
                              ?.translate(AppStringConstant.newPassword) ??
                              '',
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: AppSizes.extraPadding),
                        CommonTextField(
                          hintText: _localizations?.translate(
                              AppStringConstant.confirmPassword) ??
                              "",
                          controller: confirmPasswordController,
                          isRequired: changePassword,
                          isPassword: true,
                          inputType: TextInputType.visiblePassword,
                          validationType: AppStringConstant.password,
                          validation: (value) {
                            if (confirmPasswordController.text !=
                                passwordController.text) {
                              return _localizations?.translate(
                                  AppStringConstant.passwordNotMatch) ??
                                  '';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: AppSizes.extraPadding),
                      ],
                    ),
                  commonButton(context, () {
                    if (_formKey.currentState?.validate() == true) {
                      _accountInfoBloc?.add(SaveAccountInfoEvent(
                          nameController.text, passwordController.text));
                    }
                  }, _localizations?.translate(AppStringConstant.save) ?? '',
                      backgroundColor: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                      textColor:
                      Theme
                          .of(context)
                          .colorScheme
                          .secondaryContainer),
                ],
              ),
            ),
          )),
    );
  }

  Widget downloadInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.extraPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    _accountInfoBloc?.add(const DownloadInformationEvent());
                  },
                  child: Text(
                    _localizations?.translate(
                        AppStringConstant.downloadAllInformation) ??
                        '',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                  ),
                ),
              ],
            ),
            Visibility(
                visible: !(accountInfo?.downloadRequest ?? true),
                child:
                Flexible(child: Text(accountInfo?.downloadMessage ?? ''))),
            Visibility(
                visible: (accountInfo?.downloadRequest ?? false),
                child: TextButton(
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    print('---click on download information---');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _localizations?.translate(AppStringConstant.download) ??
                            '',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                      ),
                      const Icon(
                        Icons.download,
                        color: AppColors.lightGray,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
