import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

Widget orderHeaderLayout(BuildContext context, String heading, Widget child) {
  return Container(
    color: Theme.of(context).cardColor,
    width: AppSizes.width,
    padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading.toUpperCase(),
                style:  Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.lightGray),
              ),
              const SizedBox(
                height: AppSizes.mediumPadding,
              ),
              const Divider(
                thickness: 1,
                height: 1,
              ),
            ],
          ),
        ),
        child
      ],
    ),
  );
}