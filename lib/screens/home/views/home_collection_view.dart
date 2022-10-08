import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/home/views/product_list_widgets/product_list_widgets.dart';

class HomeCollection extends StatefulWidget {
  List<ProductSliders>? products;

  HomeCollection({this.products});

  @override
  State<StatefulWidget> createState() {
    return HomeCollectionState();
  }
}

class HomeCollectionState extends State<HomeCollection> {
  int selectedCard = -1;
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.products?.length ?? 0,
        itemBuilder: (context, index) =>
            getProductSlider(widget.products![index]));
  }

  Widget getProductSlider(ProductSliders productSliders) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
        margin: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.sidePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(AppSizes.imageRadius/2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.imageRadius/2),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: Text(productSliders.title ?? "",
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Visibility(
                        visible: getViewAllVisibility(
                            productSliders.sliderMode ?? "",
                            (productSliders.products?.length ?? 0)),
                        child: viewAllButton(context, () {
                          Navigator.pushNamed(context, catalogPage, arguments: getCatalogMap( productSliders.url ?? '', true,"Catalog",customerId: 0,));
                        })),
                  ],
                ),
              ),

            getProductListType(
                productSliders.products ?? [], productSliders.sliderMode ?? "", productSliders.url)
          ],
        ));
  }

  //==============Products List Item Types============//

  Widget getProductListType(List<Products> products, String sliderMode, String? url) {
    if (sliderMode == AppConstant.productFixed) {
      return buildGridProduct(products, _localizations, url: url);
    } else if (sliderMode == AppConstant.productDefault) {
      return buildHorizontalProduct(products, _localizations,url: url);
    } else {
      var list = [
        buildHorizontalProduct(products, _localizations, url: url),
        buildGridProduct(products, _localizations, url: url),
        buildStaggered(products),
        buildStaggeredGrid(products, _localizations),
      ];
      return (list..shuffle()).first;
    }
  }

  bool getViewAllVisibility(String sliderMode, int length) {
    if (sliderMode == AppConstant.productFixed) {
      return length.isEven ? true : false;
    } else if (sliderMode == AppConstant.productDefault) {
      if (length > 10) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

Widget viewAllButton(BuildContext context, GestureTapCallback onClick) {
  return SizedBox(
      height: AppSizes.width / 15,
      child: OutlinedButton(
        onPressed: onClick,
        child: Text(
            AppLocalizations.of(context)!.translate(AppStringConstant.viewAll),
            style: Theme.of(context).textTheme.bodyText2),
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ));
}
