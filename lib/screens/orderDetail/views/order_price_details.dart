import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_heading_view.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/OrderDetailModel.dart';

Widget orderPriceDetails(OrderDetailModel model, BuildContext context,
    AppLocalizations? localizations) {
  return orderHeaderLayout(
      context,
      localizations?.translate(AppStringConstant.priceDetails) ?? "",
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
        child: Column(
          children: [
            orderPriceDetailsItem(
                localizations?.translate(AppStringConstant.subtotal) ?? "",
                model.amountUntaxed.toString(),
                context),
            orderPriceDetailsItem(
                localizations?.translate(AppStringConstant.tax) ?? "",
                model.amountTax.toString(),
                context),
            orderPriceDetailsItem(
                localizations?.translate(AppStringConstant.grandTotal) ?? "",
                model.amountTotal.toString(),
                context)
          ],
        ),
      ));
}

Widget orderPriceDetailsItem(String key, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          key,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
