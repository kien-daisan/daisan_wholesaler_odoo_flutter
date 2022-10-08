// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
import 'package:flutter_project_structure/screens/product/views/add_product_review.dart';
import 'package:flutter_project_structure/screens/product/views/rating_container.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../constants/route_constant.dart';
import '../../../customWidgtes/dialog_helper.dart';
import '../../../helper/app_shared_pref.dart';
import '../bloc/product_screen_event.dart';
import '../bloc/product_screen_state.dart';

class ProductPageBasicDetailsView extends StatefulWidget {
  final ProductScreenModel? product;
  final ValueChanged<bool>? callback;
  bool addedToWishlist = false;
  ProductScreenBloc? productPageBloc;

  ProductPageBasicDetailsView(this.addedToWishlist, this.productPageBloc,
      {this.product, this.callback});

  @override
  State<StatefulWidget> createState() {
    return ProductPageBasicDetailsViewState();
  }
}

class ProductPageBasicDetailsViewState
    extends State<ProductPageBasicDetailsView> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.all(AppSizes.normalPadding),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(widget.product?.name ?? '',
                style: Theme.of(context).textTheme.headline5),
            SizedBox(height: AppSizes.normalPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Giá: ", style: Theme.of(context).textTheme.headline5),
                Text(
                  ((widget.product?.priceReduce ?? '') != '')
                      ? widget.product?.priceReduce ?? ''
                      : widget.product?.priceUnit ?? '',
                  // style: Theme.of(context).textTheme.headline4,
                  style: DSTheme.lightTextPrice
                ),
                SizedBox(
                  width: AppSizes.normalPadding,
                ),
                if ((widget.product?.priceReduce ?? '') != '')
                  Text(
                    widget.product?.priceUnit ?? '',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Theme.of(context).textTheme.headline4!.color,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: AppSizes.normalPadding,
            ),
            Visibility(
              visible: (widget.product?.productSku ?? '') != '',
              child: Column(
                children: [
                  Text(
                    "${AppConstant.sku.toUpperCase()}: ${widget.product?.productSku} ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: AppSizes.normalPadding,
                  ),
                ],
              ),
            ),

            Visibility(
                visible: (widget.product?.stockDisplayMsg ?? "").isNotEmpty,
                child: Column(
                  children: [
                    Text(widget.product?.stockDisplayMsg ?? '',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(height: AppSizes.normalPadding),
                  ],
                )),
            if (AppSharedPref().getSplashData()?.addons?.review ?? false)
              Visibility(
                visible: AppSharedPref().getSplashData()?.addons?.review ?? false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ((widget.product?.totalReview ?? 0) > 0)
                            ? productReviews(widget.product?.totalReview ?? 0,
                                widget.product?.avgRating ?? 0)
                            : Text(_localizations
                                    ?.translate(AppStringConstant.noReview) ??
                                ''),
                        SizedBox(
                          width: AppSizes.mediumPadding,
                        ),
                        InkWell(
                          onTap: () {
                            if (AppSharedPref().getIfLogin() != null &&
                                AppSharedPref().getIfLogin() == true) {
                              reviewBottomModalSheet(
                                  context,
                                  widget.product?.name ?? '',
                                  widget.product?.thumbNail ?? '',
                                  widget.product?.templateId ?? 0, function: () {
                                widget.productPageBloc?.emit(ProductScreenInitial());
                                widget.productPageBloc?.add(
                                    ProductScreenDataFetchEvent(
                                        widget.product?.templateId.toString()));
                              });
                            } else {
                              DialogHelper.confirmationDialog(
                                  "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                                  context,
                                  _localizations, onConfirm: () async {
                                Navigator.pushNamed(context, loginSignup,
                                    arguments: false);
                              });
                            }
                          },
                          child: Text(
                            _localizations?.translate(AppStringConstant.addReview) ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: AppColors.blue),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: AppSizes.normalPadding),
                  ],
                ),
              ),

            Divider(),
            actionContainer()
          ],
        ));
  }

  Widget productReviews(int totalReview, double avgReview) {
    return Row(
      children: [
        RatingContainer(widget.product?.avgRating?.toDouble() ?? 0.0),
        SizedBox(
          width: AppSizes.normalPadding,
        ),
        Text(
          "$totalReview ${_localizations?.translate(AppStringConstant.reviews) ?? ''}",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  Widget actionContainer() {
    return SizedBox(
        height: AppSizes.height / 23,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (AppSharedPref().getIfLogin() != null &&
                        AppSharedPref().getIfLogin() == true) {
                      !widget.addedToWishlist
                          ? widget.productPageBloc?.add(AddToWishlistEvent(
                              widget.product?.productId.toString() ?? '',
                              widget.product?.name ?? ""))
                          : widget.productPageBloc?.add(RemoveFromWishlistEvent(
                              widget.product?.productId.toString()));
                      widget.productPageBloc?.emit(ProductScreenInitial());
                      AnalyticsEventsFirebase().addWishListEvent(
                          widget.product?.productId.toString() ?? "",
                          widget.product?.name ?? "",
                          widget.product?.productCount ?? 1);
                    } else {
                      DialogHelper.confirmationDialog(
                          "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                          context,
                          _localizations, onConfirm: () async {
                        Navigator.pushNamed(context, loginSignup,
                            arguments: false);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.addedToWishlist ||
                                widget.product?.addedToWishlist == true
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: !widget.addedToWishlist
                            ? AppColors.lightGray
                            : AppColors.lightRed,
                      ),
                      SizedBox(
                        width: AppSizes.normalPadding / 2,
                      ),
                      Text(
                          _localizations
                                  ?.translate(AppStringConstant.wishList) ??
                              '',
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () async {
                    await FlutterShare.share(
                        title: widget.product?.name ?? '',
                        text: '',
                        linkUrl: widget.product?.absoluteUrl,
                        chooserTitle: '');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: AppColors.lightGray,
                      ),
                      SizedBox(
                        width: AppSizes.normalPadding / 2,
                      ),
                      Text(
                          _localizations?.translate(AppStringConstant.share) ??
                              "",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                )),
          ],
        ));
  }
}
