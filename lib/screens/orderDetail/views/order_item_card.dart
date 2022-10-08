import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/image_view.dart';
import '../../../models/OrderDetailModel.dart';

Widget orderItemCard(
    OrderItems item, BuildContext context, AppLocalizations? _localization) {
  return Container(
    padding: const EdgeInsets.only(top: AppSizes.normalPadding),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Stack(children: <Widget>[
            ImageView(
              url: item.thumbNail,
              height: (AppSizes.width / 2.5),
            ),
          ]),
        ),
        const SizedBox(
          width: AppSizes.imageRadius,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
                child: Text(item.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.normal)),
              ),
              itemDetailView(
                  '${_localization?.translate(AppStringConstant.state)}',
                  item.state ?? '',
                  context),
              itemDetailView(
                  '${_localization?.translate(AppStringConstant.price)}',
                  item.priceUnit ?? '',
                  context),
              itemDetailView(
                  '${_localization?.translate(AppStringConstant.qty)}',
                  item.qty.toString(),
                  context),
              itemDetailView(
                  '${_localization?.translate(AppStringConstant.unitPrice)}',
                  item.priceUnit.toString(),
                  context),
              itemDetailView(
                  '${_localization?.translate(AppStringConstant.tax)}',
                  item.priceTax.toString(),
                  context),
              itemDetailView(
                  '${_localization?.translate(AppStringConstant.totalPrice)}',
                  item.priceTotal.toString(),
                  context),
              if(AppSharedPref().getSplashData()?.addons?.review ?? false)
                ElevatedButton.icon(
                onPressed: () {
                  reviewBottomModalSheet(context, item.name ?? '', item.thumbNail ?? '', item.templateId ?? 0);

                },
                icon:  Icon(
                  Icons.reviews,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                label: Text(
                  '${_localization?.translate(AppStringConstant.writeAReview)}'
                      .toUpperCase(),
                  style: TextStyle(color: Theme.of(context).colorScheme.secondaryContainer),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onPrimary),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget itemDetailView(String key, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: AppSizes.linePadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            key,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    ),
  );
}
