import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_restart.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';

import '../../signin_signup/view/my_bottom_sheet.dart';

void showLanguageBottomSheet(BuildContext context, AppLocalizations? _localizations,) {
  var availableLanguages = AppSharedPref().getSplashData()?.allLanguages;
  var selectedLanguage = AppSharedPref().getAppLanguage();
  if (availableLanguages != null && availableLanguages.isNotEmpty) {
    showMyModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Scaffold(
        appBar: commonToolBar(_localizations?.translate(AppStringConstant.language) ?? '', context, isLeadingEnable: true),
        body: ListView.builder(
            itemCount: availableLanguages.length,
            itemBuilder: (context, index) {
              var item = availableLanguages[index];
              return InkWell(
                onTap: () {
                  if (selectedLanguage != item[0]) {
                    AppSharedPref().setAppLanguage(item[0]);
                    AppRestart.rebirth(context);
                    print('sadascdasd---${item[0]}');
                  }
                },
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(AppSizes.widgetSidePadding),
                  child: Text(
                    item[1],
                    style: selectedLanguage == item[0]
                        ? Theme.of(context).textTheme.headline5
                        : null,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
