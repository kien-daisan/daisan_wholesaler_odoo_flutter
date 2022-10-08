import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';

import '../../../config/theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/route_constant.dart';
import '../../../helper/image_view.dart';
import '../../../models/HomeScreenModel.dart';

class ProductItemFullWidth extends StatefulWidget {
  final Products? product;

  const ProductItemFullWidth({Key? key, this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductItemFullWidthState();
  }
}

class ProductItemFullWidthState extends State<ProductItemFullWidth> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // imageSize = (MediaQuery.of(context).size.width / 2.5) - 8;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(productPage,
            arguments: getProductDataMap(
                widget.product?.name ?? '', widget.product?.templateId.toString() ?? ''));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Theme.of(context).dividerColor,
        )),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(children: <Widget>[
                ImageView(
                  url: widget.product?.thumbNail,
                  height: (AppSizes.width / 1.9),
                ),
                // Positioned(
                //     left: 0,
                //     top: 8,
                //     child: Container(
                //       color: Colors.green,
                //       child: const Padding(
                //         padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                //         child: Text(
                //           AppStringConstant.newLabel,
                //           style: TextStyle(
                //             fontSize: 15.0,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ))
              ]),
            ),
            const SizedBox(
              width: AppSizes.imageRadius,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          (widget.product?.priceReduce ?? '').isNotEmpty
                              ? widget.product?.priceReduce ?? ''
                              : widget.product?.priceUnit ?? '',
                          style: Theme.of(context).textTheme.bodyText1
                          // const TextStyle(
                          //   fontSize: 12.0,
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.bold
                          // ),
                          ),
                      Visibility(
                          visible:
                              (widget.product?.priceReduce ?? '').isNotEmpty,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppSizes.linePadding,
                              ),
                              Text(widget.product?.priceUnit ?? '',
                                  style: Theme.of(context).textTheme.bodyText2
                                  // const TextStyle(
                                  //     fontSize: 11.0,
                                  //     decoration: TextDecoration.lineThrough),
                                  ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(widget.product?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2
                      // const TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
