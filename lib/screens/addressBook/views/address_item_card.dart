import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';

import '../../../constants/app_constants.dart';

Widget addressItemWithHeading(
    BuildContext context, String title, String address,
    {Widget? addressList,
      Widget? actions,
      bool? showDivider,
      bool? isElevated,
      VoidCallback? callback}) {
  return Container(
    color: Theme.of(context).cardColor,
    margin: const EdgeInsets.only(top: AppSizes.imageRadius),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: AppColors.lightGray),
          ),
        ),
        if (showDivider ?? false)
          const Divider(
            thickness: 1,
            height: 1,
          ),
        addressList ??
            addressItemCard(address, context,
                actions: actions, isElevated: isElevated, callback:callback )
      ],
    ),
  );
}

Widget addressItemCard(String address, BuildContext context,
    {Widget? actions, bool? isElevated, VoidCallback? callback, bool? isSelected }) {
  return Card(

    elevation: (isElevated ?? true) ? AppSizes.linePadding : 0,
    margin: const EdgeInsets.fromLTRB(0, AppSizes.imageRadius, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (callback != null) ? callback : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(address, style: (isSelected ?? false) ?const TextStyle(fontWeight: FontWeight.bold) : null,)),
                if(callback != null) const Icon(Icons.navigate_next, color: AppColors.lightGray,)
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 0.5,
          height: 0.5,
        ),
        if (actions != null) actions,
      ],
    ),
  );
}

Widget actionContainer(
    BuildContext context, VoidCallback leftCallback, VoidCallback rightCallback,
    {IconData? iconLeft,
      IconData? iconRight,
      String? titleLeft,
      String? titleRight}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: leftCallback,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconLeft ?? Icons.edit,
                    size: AppSizes.widgetSidePadding ,
                  ),
                  const SizedBox(
                    width: AppSizes.linePadding,
                  ),
                  Text(
                      (titleLeft ?? '').toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            )),
        if((iconRight !=Icons.rate_review_outlined) || ((iconRight == Icons.rate_review_outlined) && (AppSharedPref().getSplashData()?.addons?.review ?? false)) )
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: rightCallback,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconRight ?? Icons.add,
                      size: AppSizes.widgetSidePadding ,
                    ),
                    const SizedBox(
                      width: AppSizes.linePadding,
                    ),
                    Text(
                      // _localizations?.translate(AppStringConstant.newAddress) ??
                        (titleRight ?? "").toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontWeight: FontWeight.bold))
                  ],
                ),
              )),
      ],
    ),
  );
}
