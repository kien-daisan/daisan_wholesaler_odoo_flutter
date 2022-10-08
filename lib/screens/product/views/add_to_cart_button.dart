import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';

class AddToCartButtonView extends StatelessWidget {
  AppLocalizations? _localizations;
  ProductScreenBloc? productPageBloc;
  int productId;
  int counter;
  String productName;
  final ValueChanged<bool>? callback;

  AddToCartButtonView(this.productPageBloc, this.productId,this.productName, this.counter,
      {Key? key, this.callback});

  // @override
  // void didChangeDependencies() {

  // }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    return Container(
        height: AppSizes.height / 13,
        child: Container(
          color: Theme.of(context).cardColor,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (AppSharedPref().getIfLogin() != null &&
                          AppSharedPref().getIfLogin() == true) {
                        productPageBloc?.add(
                            AddtoCartEvent(productId.toString(), counter));
                        productPageBloc?.emit(ProductScreenInitial());

                      } else {
                        DialogHelper.confirmationDialog(
                            "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                            context,
                            _localizations, onConfirm: () async {
                          Navigator.pushNamed(context, loginSignup, arguments: false);
                        });
                      }
                    },
                    child: Center(
                        child: Text(
                          _localizations
                              ?.translate(AppStringConstant.addToCart) ??
                              '',
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (AppSharedPref().getIfLogin() != null &&
                          AppSharedPref().getIfLogin() == true) {
                        productPageBloc?.add(BuyNowEvent(productId.toString(), counter));
                        productPageBloc?.emit(ProductScreenInitial());
                      } else {
                        DialogHelper.confirmationDialog(
                            "${_localizations?.translate(AppStringConstant.signInToContinue)}", context, _localizations,
                            onConfirm: () async {
                              Navigator.pushNamed(context, loginSignup,arguments: false);
                            });
                      }
                    },
                    child: Container(
                      height: double.infinity,
                      child: Center(
                          child: Text(
                            _localizations?.translate(AppStringConstant.buyNow) ??
                                '',
                            style: const TextStyle(
                                color: AppColors.white, fontSize: 16),
                          )),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                        borderRadius: BorderRadius.circular(2)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
