import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/cart/cart_screen.dart';
import 'package:flutter_project_structure/screens/cart/widgets/quantity_drop_down.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(this.product, this.localizations,this.bloc, {Key? key})
      : super(key: key);

  final Items? product;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.mediumPadding),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, productPage, arguments: getProductDataMap(product?.name ?? '', product?.templateId.toString() ?? ''));

        },
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: AppSizes.mediumPadding,left: AppSizes.mediumPadding,top: AppSizes.imageRadius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Image and qty dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageView(
                          url: product?.thumbNail,
                          height: AppSizes.height/7,
                          width: AppSizes.width/4,
                        ),
                        SizedBox(
                          height: AppSizes.buttonRadius,
                          child: QuantityDropDown(
                                (value) async {
                              String operator = "";
                              if (int.tryParse(value)! >
                                  (product?.qty?.toInt() ?? 1)) {
                              }
                              bloc?.add(SetCartItemQuantityEvent(product?.lineId ?? 0, int.tryParse(value) ?? 1));
                              bloc?.emit(CartScreenInitial());


                            },
                            product?.qty?.toInt()
                            // product?.
                          ),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),

                    const SizedBox(width: AppSizes.mediumPadding),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(product?.name ?? "",style:Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal)),
                          const SizedBox(height: AppSizes.imageRadius),
                          Text(
                            product?.priceUnit ?? "0.00",
                            style: Theme.of(context).textTheme.headline6
                          ),
                          const SizedBox(height: AppSizes.imageRadius),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text((localizations?.translate(AppStringConstant.subtotal) ??
                                  "") +
                                  ": ", style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),),
                              Text(
                                (product?.total ?? "0.00"),
                                style: Theme.of(context).textTheme.headline6
                              ),
                            ],
                          )
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),

                    // Edit button
                    InkWell(
                      onTap: () {
                       Navigator.pushNamed(context, productPage, arguments: getProductDataMap(product?.name ?? '', product?.templateId.toString() ?? ''));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(AppSizes.imageRadius),
                        child: Icon(Icons.edit,size: AppSizes.genericPadding,),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: _iconButton(
                      Icons.favorite_border,
                      localizations?.translate(AppStringConstant.moveToWishlist) ?? "",
                      () {
                        DialogHelper.confirmationDialog(AppStringConstant.moveToWishlistText, context, localizations,onConfirm: (){
                          bloc?.add(CartToWishlistEvent(product?.name ?? "", product?.lineId ?? 0));
                          bloc?.emit(CartScreenInitial());
                        });
                      },
                      context
                    ),
                  ),
                  Expanded(
                    child: _iconButton(
                      Icons.delete_forever,
                      localizations?.translate(AppStringConstant.removeItem) ?? "",
                          () {
                        DialogHelper.confirmationDialog(AppStringConstant.deleteItemFromCart,context, localizations,
                            onConfirm: () async {
                              bloc?.add(RemoveCartItem(product?.lineId ?? 0));
                              bloc?.emit(CartScreenInitial());
                              AnalyticsEventsFirebase().removeFromCart(product?.lineId.toString() ?? "0", product?.name ?? "0",);
                              });
                      },
                      context
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
      IconData icon,
      String title,
      VoidCallback onTap,
      BuildContext context) =>
      Container(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon,color: Theme.of(context).iconTheme.color,),
                const SizedBox(width: AppSizes.linePadding),
                Flexible(child: Text(title.toUpperCase(),style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ),
      );
}
