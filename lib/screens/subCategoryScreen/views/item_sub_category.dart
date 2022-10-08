import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

import '../../../constants/app_constants.dart';

Widget getItemSubCategory(
    BuildContext context, List<Children>? subCategoryList, int index) {
  return GestureDetector(
    onTap: () {
      if ((subCategoryList?[index].children ?? []).isNotEmpty) {
        Navigator.pushNamed(context, subCategory,
            arguments: subCategoryDataMap(subCategoryList?[index].children,
                subCategoryList?[index].children?[index].categoryId,subCategoryList?[index].name ?? ""));
      } else {
        print(subCategoryList?[index].toJson());
        Navigator.pushNamed(context, catalogPage,
            arguments: getCatalogMap(
                 "", false,subCategoryList?[index].name ?? "Catalog",customerId: subCategoryList?[index].categoryId ?? 0,));
      }
    },
    child: Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(
          vertical: AppSizes.linePadding, horizontal: AppSizes.imageRadius),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.sidePadding, horizontal: AppSizes.imageRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subCategoryList?[index].name ?? "",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Icon(Icons.arrow_right)
        ],
      ),
    ),
  );
}
