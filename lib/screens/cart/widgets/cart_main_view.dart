import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/cart/widgets/price_details.dart';

import 'cart_icon_button.dart';
import 'cart_product_item.dart';

class CartMainView extends StatelessWidget {
  const CartMainView(
      this.model, this.localizations,
      this.bloc,
      {Key? key})
      : super(key: key);

  final CartViewModel? model;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // products list view
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.extraPadding),
              child: Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius,vertical: AppSizes.linePadding),
                      child: Text(
                          "${model?.cartCount} " + (localizations?.translate(AppStringConstant.items) ?? "").toUpperCase(),
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600)
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => CartProductItem(model?.items?[index], localizations,bloc),
              itemCount:
              (model?.items?.length ?? 0),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),

        /// vouchers listview
        /// uncomment this part with proper data (voucher data)
        // Card(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children:<Widget>[
        //       const Padding(
        //         padding: const EdgeInsets.all(AppSizes.spacingNormal),
        //         child: Text(
        //           "Vouchers",
        //           style: const TextStyle(fontSize: TextSizes.textSize18),
        //         ),
        //       ),
        //       const Divider(thickness: 1),
        //       ListView.separated(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemBuilder: (ctx, index) => const CartVoucherItem(),
        //         separatorBuilder: (ctx, index) => const SizedBox(
        //           height: AppSizes.spacingTiny,
        //         ),
        //         itemCount: 2,
        //       ),
        //     ],
        //   ),
        // ),

        // apply coupon
        // if (model?.carts?.cart?.voucherEnabled == "1")
        //   Discount(bloc, localizations),
        CartIconButton(
          leadingIcon: Icons.update,
          title: localizations?.translate(AppStringConstant.updateShoppingCart).toUpperCase() ?? "",
          onClick: () {
              bloc?.add(const CartScreenDataFetchEvent());
              bloc?.emit(CartScreenInitial());

          },
        ),
        CartIconButton(
          leadingIcon: Icons.delete_forever,
          title: localizations?.translate(AppStringConstant.emptyCart) ?? "",
          onClick: () {
            DialogHelper.confirmationDialog(AppStringConstant.emptyCartText,context, localizations, onConfirm: (){
              bloc?.add(SetCartEmpty());
              bloc?.emit(CartScreenInitial());
            });

          },
        ),
        CartIconButton(
          leadingIcon: Icons.arrow_forward,
          title: localizations?.translate(AppStringConstant.continueShopping) ?? "",
          onClick: () {
          Navigator.pushNamed(context, navBar);
          },
        ),

        PriceDetails(
          totalProducts: model?.subtotal?.value,
          grandTotal: model?.grandtotal?.value,
          localizations: localizations,
          totalTax: model?.tax?.value,
        ),
      ],
    );
  }
}
