import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../config/theme.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';

Widget commonOrderButton(BuildContext context, AppLocalizations? _localizations, String amount, VoidCallback onPressed, {Color color = MobikulTheme.accentColor,String title = AppStringConstant.proceed}){
  return Container(
    // height: 55,
    color: Theme.of(context).cardColor,
  padding:  const EdgeInsets.all(AppSizes.imageRadius),
  child: Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(_localizations
                ?.translate(AppStringConstant.amountToBePaid) ??
                "",style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 13),),
            Text(amount,
                style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)
              // ?.copyWith(fontSize: TextSizes.mediumTextSize),
            )
          ],
        ),
      ),
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            (_localizations?.translate(title) ?? "")
                .toUpperCase(),
            style: const TextStyle(color: AppColors.white),
          ),
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: color),
        ),
      )
    ],
  ),
);
}