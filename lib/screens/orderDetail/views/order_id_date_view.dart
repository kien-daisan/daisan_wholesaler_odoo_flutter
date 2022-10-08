import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';

import '../../../constants/app_constants.dart';

Widget orderIdContainer(BuildContext context, OrderDetailModel? _orderModel, AppLocalizations? _localization) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.mediumPadding),
          topRight: Radius.circular(AppSizes.mediumPadding)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.mediumPadding,
        ),
        Text(
          '${_localization?.translate(AppStringConstant.order)}${_orderModel?.name}',
          style: Theme.of(context)
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
  );
}

Widget orderPlaceDateContainer(BuildContext context, OrderDetailModel? _orderModel, AppLocalizations? _localization) {
  return Container(
      color: Theme.of(context).cardColor,
      width: AppSizes.width,
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.mediumPadding, horizontal: AppSizes.imageRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _localization?.translate(AppStringConstant.placedOn)??"",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.lightGray),
              ),
              SizedBox(
                height: AppSizes.linePadding,
              ),
              Text(
                _orderModel?.createDate ?? "",
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.linePadding,
                vertical: AppSizes.linePadding),
            color: AppColors.yellow,
            child: Text(
              _orderModel?.status ?? "".toUpperCase(),
              style: TextStyle(color: AppColors.white),
            ),
          )
        ],
      ));
}