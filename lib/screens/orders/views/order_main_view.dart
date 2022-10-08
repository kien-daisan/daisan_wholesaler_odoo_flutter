import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';

Widget orderMainView(BuildContext context, List<RecentOrders>? orders,
    AppLocalizations? localizations, Function(String url) callback, ScrollController controller,{ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics()} ) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    physics: scrollPhysics,
    itemBuilder: (ctx, index) =>
        orderItem(context, orders?[index], localizations, callback),
    separatorBuilder: (ctx, index) => const SizedBox(
      height: AppSizes.linePadding,
      child: Divider(),
    ),
    itemCount: (orders?.length ?? 0),
  );
}

Widget orderItem(BuildContext context, RecentOrders? item,
    AppLocalizations? localizations, Function(String) callback) {
  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.imageRadius,
        left: AppSizes.imageRadius,
        right: AppSizes.imageRadius),
    margin: const EdgeInsets.only(bottom: AppSizes.imageRadius),
    color: Theme.of(context).cardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "#${item?.name.toString() ?? " "}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: AppSizes.imageRadius),
                  statusContainer(context, item?.status ?? ''),
                  const SizedBox(height: AppSizes.imageRadius),
                  Text(
                    item?.createDate ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: AppSizes.imageRadius),
                  Text(item?.amountTotal ?? "0.00",
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: AppSizes.imageRadius),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),

            // Edit button
          ],
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
        actionContainer(
          context,
          () {
            Navigator.pushNamed(context, orderDetails, arguments: item?.url);
          },
          () {
            callback(item?.url ?? '');
          },
          titleRight: localizations?.translate(AppStringConstant.reviews),
          titleLeft: localizations?.translate(AppStringConstant.details),
          iconRight: Icons.rate_review_outlined,
          iconLeft: Icons.navigate_next,
        )
      ],
    ),
  );
}

Widget statusContainer(BuildContext context, String status) {
  return Container(
    color: containerColor(status),
    padding: const EdgeInsets.symmetric(
        vertical: AppSizes.imageRadius / 2, horizontal: AppSizes.imageRadius),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Text(
          status,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: AppColors.white),
        )),
      ],
    ),
  );
}

Color containerColor(String status) {
  switch (status.toUpperCase()) {
    case 'COMPLETE':
      return AppColors.green;
    default:
      return AppColors.yellow;
  }
}
