import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

import '../../../config/theme.dart';
import '../../../constants/app_constants.dart';
import 'item_sub_category.dart';

Widget categoriesListCard(BuildContext context, List<Children>? subCategoryList,
    AppLocalizations? localization) {
  return Visibility(
    visible: (subCategoryList ?? []).isNotEmpty,
    child: Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.sidePadding, horizontal: AppSizes.imageRadius),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${localization?.translate(AppStringConstant.subCategories)}',
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(
            height: AppSizes.sidePadding,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subCategoryList?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return getItemSubCategory(context, subCategoryList, index);
              })
        ],
      ),
    ),
  );
}
