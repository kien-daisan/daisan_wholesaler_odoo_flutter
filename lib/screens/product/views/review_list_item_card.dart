import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/screens/product/views/rating_container.dart';

import '../../../constants/app_constants.dart';
import '../../../models/ReviewListModel.dart';

Widget reviewListItemCard(ProductReviews? reviewData, BuildContext context,
    GestureTapCallback onLike, GestureTapCallback onDislike) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RatingContainer(reviewData?.rating ?? 1),
          const SizedBox(
            width: AppSizes.normalPadding / 2,
          ),
          Text(
            '${reviewData?.title}',
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Flexible(child: Text("${reviewData?.msg}")),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Text(
        '${reviewData?.customer}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.headline3?.color),
      ),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Text(
        '(${reviewData?.createDate})',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(
        height: AppSizes.normalPadding,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onLike,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border_outlined),
                SizedBox(
                  width: AppSizes.normalPadding / 2,
                ),
                Text("${reviewData?.likes ?? 0}",
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ),
          InkWell(
            onTap: onDislike,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border_outlined),
                SizedBox(
                  width: AppSizes.normalPadding / 2,
                ),
                Text("${reviewData?.dislikes ?? 0}",
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          )
        ],
      ),
    ],
  );
}
