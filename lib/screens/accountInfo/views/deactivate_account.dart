import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

Widget deactivateAccount(BuildContext context, AppLocalizations? _localizations, VoidCallback tempCallback, VoidCallback permCallback) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.extraPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_localizations?.translate(AppStringConstant.deactivateTitle) ??
              ''),
          Row(
            children: [
              Expanded(
                  child: Text(_localizations?.translate(
                      AppStringConstant.deactivateTemporary) ??
                      '')),
              commonButton(context, tempCallback,
                  _localizations?.translate(AppStringConstant.deactivate) ??
                      '',
                  width: AppSizes.width / 4,
                  height: AppSizes.height / 25,
                  textColor: Theme.of(context).colorScheme.secondaryContainer,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(_localizations?.translate(
                      AppStringConstant.deactivatePermanent) ??
                      '')),
              commonButton(context, permCallback,
                  _localizations?.translate(AppStringConstant.deactivate) ??
                      '',
                  width: AppSizes.width / 4,
                  height: AppSizes.height / 25,
                  textColor: Theme.of(context).colorScheme.secondaryContainer,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ],
          )
        ],
      ),
    ),
  );
}
