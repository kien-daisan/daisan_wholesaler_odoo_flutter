import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

class ItemCard extends StatelessWidget {
  double? imageSize;

  final Products? product;

  ItemCard({this.product, this.imageSize});

  @override
  @override
  Widget build(BuildContext context) {
    imageSize ??= (AppSizes.width / 2.5) - AppSizes.linePadding;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(productPage,
            arguments: getProductDataMap(
                product?.name ?? '', product?.templateId.toString() ?? ''));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: MobikulTheme.lightGrey,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(children: <Widget>[
              Center(
                child: ImageView(
                  fit: BoxFit.fill,
                  url: product?.thumbNail,
                  width: imageSize!,
                  height: imageSize!,
                ),
              ),
            ]),
            SizedBox(
              width: imageSize,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.imageRadius,
                    top: AppSizes.imageRadius,
                    right: AppSizes.imageRadius),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                            (product?.priceReduce ?? '').isNotEmpty
                                ? product?.priceReduce ?? ''
                                : product?.priceUnit ?? '',
                            style: Theme.of(context).textTheme.bodyText1),
                        Visibility(
                            visible: (product?.priceReduce ?? '').isNotEmpty,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: AppSizes.linePadding,
                                ),
                                Text(product?.priceUnit ?? '',
                                    // style: Theme.of(context).textTheme.bodyText2
                                     style: const TextStyle(
                                        fontSize: 11.0,
                                        decoration: TextDecoration.lineThrough),
                                    ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(product?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyText2
                        // const TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
