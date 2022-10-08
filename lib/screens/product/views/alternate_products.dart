import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';

import '../../../config/theme.dart';
import '../../../constants/app_constants.dart';
import '../../../models/ProductScreenModel.dart';

class AlternateProductsList extends StatelessWidget {
  List<AlternativeProducts>? alternativeProducts;

  AlternateProductsList(this.alternativeProducts);

  @override
  Widget build(BuildContext context) {
    if ((alternativeProducts ?? []).isNotEmpty) {
      return Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
        margin: const EdgeInsets.only(top: AppSizes.normalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.sidePadding),
              child: Text(
                  AppLocalizations.of(context)
                          ?.translate(AppStringConstant.alternateProducts) ??
                      "",
                  style: Theme.of(context).textTheme.headline5),
            ),
            SizedBox(
              height: AppSizes.width / 2,
              width: AppSizes.width,
              child: ListView.builder(
                  itemCount: alternativeProducts?.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = alternativeProducts![index];
                    return productCard(data, context);
                  }),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget productCard(AlternativeProducts product, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(productPage,
            arguments:
            getProductDataMap(product.name ?? '', product.templateId.toString()));
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ImageView(
                url: product.image,
                width: AppSizes.width / 3,
                height: (AppSizes.width / 2) * 0.7),
            SizedBox(
              height: (AppSizes.width / 2) * 0.2,
              width: AppSizes.width / 3,
              child: Text(
                "${product.name}",
                textAlign: TextAlign.center,
                style: AppTheme.smallBoldText,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
