import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../helper/alert_message.dart';
import '../helper/app_shared_pref.dart';
import '../models/SplashScreenModel.dart';
import '../screens/profile/view/privacy_policy.dart';
import '../utils/helper.dart';
import 'common_text_field.dart';

class DialogHelper {
  static quantityDialog(BuildContext context, AppLocalizations? localizations,
      {ValueChanged<String>? onSave, String? initialValue}) {
    // initial value 0
    final TextEditingController _textEditingController =
        TextEditingController(text: initialValue ?? "0");
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSizes.genericPadding,
              AppSizes.genericPadding, AppSizes.genericPadding, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                localizations?.translate(AppStringConstant.enterQuantity) ?? "",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: AppSizes.imageRadius),
              TextField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText:
                      localizations?.translate(AppStringConstant.quantity) ??
                          "",
                  border: const OutlineInputBorder(),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                          localizations?.translate(AppStringConstant.cancel) ??
                              "",
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (onSave != null) {
                          onSave(_textEditingController.text);
                          Navigator.of(ctx).pop();
                        }
                      },
                      child: Text(
                        localizations?.translate(AppStringConstant.save) ?? "",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  static confirmationDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {VoidCallback? onConfirm,
      VoidCallback? onCancel,
      bool? barrierDismissible}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (ctx) => AlertDialog(
        content: Text(
          localizations?.translate(text) ?? "",
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onCancel != null) {
                onCancel();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.cancel) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.ok) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  static locationPermissionDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
            localizations?.translate(AppStringConstant.userYourLocation) ?? ""),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations?.translate(text) ?? "",
            ),
            Visibility(
              visible: AppSharedPref().getSplashData()?.termsAndConditions ?? false,
              child: TextButton.icon(
                  onPressed: () {
                    SplashScreenModel? model = AppSharedPref().getSplashData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PrivacyPolicy(model?.privacyPolicyUrl)));
                  },
                  icon: Icon(
                    Icons.privacy_tip_sharp,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: Text(
                      localizations?.translate(AppStringConstant.privacyPolicy) ??
                          "",
                      style: Theme.of(context).textTheme.labelLarge)),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              (localizations?.translate(AppStringConstant.cancel) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.ok) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  //------------------Dio Exception Dialog------------------------//
  static showExceptionDialog(String text, BuildContext context,
      {VoidCallback? onConfirm, String? buttonText}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(
          text,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              buttonText ?? 'Retry',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  //==============Forgot Password Dialog===========//
  static forgotPasswordDialog(BuildContext context,
      AppLocalizations? localizations, String title, String message,
      {ValueChanged<String>? onConfirm,
      ValueChanged<bool>? onCancel,
      bool isForgotPassword = true}) {
    var textEditingController = TextEditingController(text: "");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: AppSizes.normalPadding,
            ),
            if (isForgotPassword)
              TextField(
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText:
                      localizations?.translate(AppStringConstant.emailAddress),
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                  border: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                      borderSide: BorderSide(
                        color: AppColors.black,
                      )),
                  focusedBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                      borderSide: BorderSide(
                        color: AppColors.black,
                      )),
                  enabledBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                      borderSide: BorderSide(
                        color: AppColors.black,
                      )),
                ),
              )
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(AppSizes.genericPadding,
            AppSizes.genericPadding, AppSizes.genericPadding, 0),
        actionsPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(AppSizes.genericPadding),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (isForgotPassword) {
                if (textEditingController.text.isEmpty) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showError(
                        localizations
                                ?.translate(AppStringConstant.invalidEmail) ??
                            '',
                        context);
                  });
                  return;
                }
                Helper.hideSoftKeyBoard();
                if (onConfirm != null)
                  onConfirm(textEditingController.text.trim());
              } else {
                if (onConfirm != null) {
                  onConfirm("");
                } //----Just to receive empty callback
              }
              Navigator.of(context).pop();
            },
            child: Text(localizations?.translate(AppStringConstant.ok) ?? '',
                style: Theme.of(context).textTheme.headline6),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) {
                onCancel(true);
              }
            },
            child: Text(
                localizations?.translate(AppStringConstant.cancel) ?? "",
                style: Theme.of(context).textTheme.headline6),
          ),
        ],
      ),
    );
  }

  //===============Search Screen Text/Image selection=========//
  static searchDialog(BuildContext context, AppLocalizations? localizations,
      GestureTapCallback onImageTap, GestureTapCallback onTextTap) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (ctx) => AlertDialog(
        // titlePadding: const EdgeInsets.all(AppSizes.genericPadding),
        title: Text(
            localizations?.translate(AppStringConstant.searchByScanning) ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: AppColors.lightGray)),
        backgroundColor: Theme.of(context).canvasColor,
        contentPadding: const EdgeInsets.all(AppSizes.genericPadding),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: onTextTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.format_color_text),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.genericPadding),
                    child: Text(
                        localizations?.translate(AppStringConstant.text) ?? "",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onImageTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.image_search),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.genericPadding),
                    child: Text(
                        localizations?.translate(AppStringConstant.image) ?? "",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=====================SignUp Term And Conditions===================//

  static signUpTerms(
    String data,
    BuildContext context,
  ) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (ctx) => AlertDialog(
        scrollable: true,
        contentPadding: const EdgeInsets.all(AppSizes.normalPadding),
        content: Html(
          data: data,
          style: {"body": Style(fontSize: FontSize.large)},
        ),
      ),
    );
  }

  //=========Delete Account Dialog==============//
  static deleteAccountConfirmationDialog(
      BuildContext context,
      String title,
      String description,
      Function(String)? onConfirm,
      AppLocalizations? _localizations) {
    TextEditingController _passwordEditingController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headline6),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: AppSizes.genericPadding,
                ),
                CommonTextField(
                  hintText:
                      _localizations?.translate(AppStringConstant.password) ?? "",
                  controller: _passwordEditingController,
                  isRequired: true,
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  validationType: AppStringConstant.password,
                ),
                const SizedBox(
                  height: AppSizes.genericPadding,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              _localizations?.translate(AppStringConstant.cancel) ?? 'Cancel',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                Helper.hideSoftKeyBoard();
                if (onConfirm != null) {
                  //closeDialog(ctx);
                  onConfirm(_passwordEditingController.text);
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(_localizations?.translate(AppStringConstant.ok) ?? 'Ok',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
