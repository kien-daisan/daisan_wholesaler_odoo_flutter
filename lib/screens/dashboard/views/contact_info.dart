
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

Widget contactInfo(BuildContext context, AppLocalizations? _localizations, String title, String name, String email) {
  return Wrap(children: [
    Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.imageRadius, vertical: AppSizes.imageRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: AppColors.lightGray),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(accountInfo);
                      },
                      child: Text(
                        _localizations?.translate(AppStringConstant.edit) ?? '',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ))
                ],
              ),
              const Divider(
                thickness: 1,
                height: 1,
              ),
              const SizedBox(
                height: AppSizes.normalPadding,
              ),
              Text(name),
              Text(email),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(accountInfo);
                    },
                    child: Text(
                      _localizations
                          ?.translate(AppStringConstant.changePassword) ??
                          '',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    )),
              )
            ],
          ),
        )),
  ]);
}
