import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../constants/app_string_constant.dart';

class HomeFeaturedCategories extends StatefulWidget {
  HomeFeaturedCategories(this.categories);

  List<FeaturedCategories> categories = [];

  @override
  _HomeFeaturedCategoriesState createState() => _HomeFeaturedCategoriesState();
}

class _HomeFeaturedCategoriesState extends State<HomeFeaturedCategories> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: AppSizes.sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.imageRadius,
                vertical: AppSizes.sidePadding),
            child: Container(
                padding: const EdgeInsets.all(AppSizes.imageRadius/2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.imageRadius/2),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              child: Text(
                  _localizations
                          ?.translate(AppStringConstant.featureCategories) ??
                      "",
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(AppSizes.imageRadius,
               0.0, AppSizes.imageRadius, 0.0),
            height: AppSizes.width / 4,
            width: AppSizes.width.toDouble(),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return categoryCardCircle(widget.categories[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget categoryCardCircle(FeaturedCategories category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, AppSizes.genericPadding, AppSizes.linePadding),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              width: AppSizes.width / 6,
              height: AppSizes.width / 6,
              padding: const EdgeInsets.all(AppSizes.imageRadius/2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular((AppSizes.width / 6) / 2)),
                  border:
                      Border.all(color: MobikulTheme.accentColor, width: 2.0)),
              child: CircleAvatar(
                backgroundColor: MobikulTheme.primaryColor,
                child: Image.network(
                  category.url ?? "",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, subCategory,
                  arguments: subCategoryDataMap(
                      category.children, category.categoryId, category.categoryName.toString()));
            },
          ),
          const SizedBox(
            height: AppSizes.linePadding,
          ),
          Text(
            category.categoryName ?? "",
            style: AppTheme.smallBoldText,
          )
        ],
      ),
    );
  }
}
