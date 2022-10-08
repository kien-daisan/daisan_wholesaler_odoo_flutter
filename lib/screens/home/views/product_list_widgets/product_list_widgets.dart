import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../models/HomeScreenModel.dart';
import '../item_card.dart';
import '../product_item_full_width.dart';

Widget buildGridProduct(
    List<Products> products, AppLocalizations? _localizations,
    {String? url, bool isCatalog = false}) {
  //----------Will Call if type is AppConstant.productFixed
  return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (1 - (90 / AppSizes.width / 2)),
        mainAxisSpacing: 6,
        crossAxisSpacing: 6
      ),
      itemCount: products.length.isEven ? products.length : products.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == products.length) {
          return isCatalog
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, catalogPage,
                        arguments: getCatalogMap( url!, true ,"Catalog",customerId: 0,));
                    print(url);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Theme.of(context).dividerColor,
                    )),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_right),
                          const SizedBox(
                            height: AppSizes.imageRadius,
                          ),
                          Text(
                            _localizations
                                    ?.translate(AppStringConstant.viewAll) ??
                                "",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                  ),
                );
        } else {
          var data = products[index];
          return GestureDetector(
            onTap: () {},
            child: ItemCard(product: data),
          );
        }
      });
}

Widget buildHorizontalProduct(
    List<Products> products, AppLocalizations? _localizations,
    {String? url}) {
  //----------Will Call if type is AppConstant.productDefault
  return SizedBox(
    width: AppSizes.width.toDouble(),
    height: (AppSizes.width / 1.9),
    child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount:
            (products.length.isOdd && (url != null)) ? products.length + 1 : products.length ,

        itemBuilder: (BuildContext context, int index) {
          if ((index == products.length) && url != null ) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, catalogPage,
                    arguments: getCatalogMap( url, true ,"Catalog",customerId: 0,));
              },
              child: Container(
                height: ((AppSizes.width / 2.5) - 8) - 3,
                width: (AppSizes.width -
                        (AppSizes.linePadding + AppSizes.linePadding)) /
                    2.5,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).dividerColor,
                )),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_right),
                      const SizedBox(
                        height: AppSizes.imageRadius,
                      ),
                      Text(
                          _localizations
                                  ?.translate(AppStringConstant.viewAll) ??
                              "",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
              ),
            );
          } else {
            var data = products[index];
            return GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  ItemCard(
                    product: data,
                    imageSize: (AppSizes.width -
                        (AppSizes.linePadding + AppSizes.linePadding)) /
                        2.5,
                  ),
                  const SizedBox(width: 6)
                ],
              )

            );
          }
        }),
  );
}

Widget buildStaggered(List<Products> products) {
  //----------Will Call for random widgets
  List<Widget> customViews = [];
  for (int i = 0; i < products.length; i++) {
    if ((i + 1) % 3 == 0) {
      print("ewewfwe--Code3$i");
      customViews.add(SizedBox(
        height: (AppSizes.width / 1.9),
        width: AppSizes.width - (AppSizes.linePadding + AppSizes.linePadding),
        child: ProductItemFullWidth(
          product: products[i],
        ),
      ));
      i++;
    } else {
      if (i == 0) {
        continue;
      }
      print("ewewfwe--Code2$i----${i - 1}");
      customViews.add(Row(
        children: [
          SizedBox(
            width: AppSizes.width / 2 -
                (AppSizes.linePadding + AppSizes.linePadding),
            child: ItemCard(
              product: products[i - 1],
              imageSize: AppSizes.width / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
            ),
          ),
          SizedBox(
            width: AppSizes.width / 2 -
                (AppSizes.linePadding + AppSizes.linePadding),
            child: ItemCard(
              product: products[i],
              imageSize: AppSizes.width / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
            ),
          )
        ],
      ));
    }
  }
  return Column(children: customViews);
}

Widget buildStaggeredGrid(
    List<Products> products, AppLocalizations? _localizations) {
  if (products.length < 5) {
    var list = [
      buildHorizontalProduct(products, _localizations),
      buildGridProduct(products, _localizations),
      buildStaggered(products)
    ];
    return (list..shuffle()).first;
  } else {
    var totalWidth =
        AppSizes.width - ((AppSizes.imageRadius + AppSizes.imageRadius));
    var totalHeight = AppSizes.height / 1.3;
    var imageHeight = (AppSizes.height) / 1.9;
    return Row(
      children: [
        SizedBox(
          width: totalWidth * 0.6,
          child: Column(
            children: [
              SizedBox(
                height: totalHeight / 2,
                child: ItemCard(
                  product: products[0],
                  imageSize: imageHeight * 0.6,
                ),
              ),
              SizedBox(
                height: totalHeight / 2,
                child: ItemCard(
                  product: products[1],
                  imageSize: imageHeight * 0.6,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: totalWidth * 0.4,
          child: Column(
            children: [
              SizedBox(
                height: totalHeight / 3,
                child: ItemCard(
                  product: products[2],
                  imageSize: imageHeight / 3,
                ),
              ),
              SizedBox(
                height: totalHeight / 3,
                child: ItemCard(
                  product: products[3],
                  imageSize: imageHeight / 3,
                ),
              ),
              SizedBox(
                height: totalHeight / 3,
                child: ItemCard(
                  product: products[4],
                  imageSize: imageHeight / 3,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
