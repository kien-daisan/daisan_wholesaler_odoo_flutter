import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/route_constant.dart';
import '../../../helper/loader.dart';
import '../../../models/HomeScreenModel.dart';
import '../../home/views/home_collection_view.dart';
import '../../home/views/item_card.dart';

Widget buildCategoryProducts(List<Products> products, AppLocalizations? _localizations, BuildContext context, bool? isLoading, int? cid,String categoryName) {
  return (isLoading ?? false)
      ? Loader()
      : Visibility(
    visible: products.isNotEmpty,
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.genericPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.imageRadius/2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.imageRadius/2),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Text(
                  _localizations
                      ?.translate(AppStringConstant.products) ??
                      "",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              viewAllButton(context, () {
                Navigator.of(context).pushNamed(catalogPage, arguments: getCatalogMap( "", false,categoryName,customerId: cid!));
              }),
            ],
          ),
          const SizedBox(height: AppSizes.imageRadius,),
          SizedBox(
            width: AppSizes.width.toDouble(),
            height: (AppSizes.width / 1.9),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:  products.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = products[index];
                  return GestureDetector(
                    onTap: () {},
                    child: ItemCard(
                      product: data,
                      imageSize: (AppSizes.width -
                          (AppSizes.linePadding +
                              AppSizes.linePadding)) /
                          2.5,
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}