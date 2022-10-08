import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/WishlistModel.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_event.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_state.dart';
import 'package:flutter_project_structure/screens/wishlist/view/empty_wishlist_view.dart';
import '../../constants/app_constants.dart';
import '../../constants/route_constant.dart';
import '../../helper/alert_message.dart';
import '../../helper/image_view.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  AppLocalizations? _localizations;
  WishlistModel? wishlistModel;
  bool isLoading = true;
  bool isAction = false;
  WishlistScreenBloc? wishlistScreenBloc;

  @override
  void initState() {
    wishlistScreenBloc = context.read<WishlistScreenBloc>();
    wishlistScreenBloc?.add(WishlistDataFetchEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.wishList) ?? "",
            context,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, cart);
                  },
                  icon: BadgeIcon(
                    icon: const Icon(Icons.shopping_cart),
                  )),
            ]),
        body: BlocBuilder<WishlistScreenBloc, WishlistState>(
            builder: (context, currentState) {
          if (currentState is WishlistInitialState) {
            isLoading = true;
          } else if (currentState is WishlistScreenSuccess) {
            isLoading = false;
            isAction = false;
            wishlistModel = currentState.wishlistModel;
          } else if (currentState is WishlistActionState) {
            isAction = true;
          } else if (currentState is MoveToCartSuccess) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel?.message ?? '', context);
            });
            wishlistScreenBloc?.add(WishlistDataFetchEvent());
          } else if (currentState is RemoveItemSuccess) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel?.message ?? '', context);
            });
            wishlistScreenBloc?.add(WishlistDataFetchEvent());
          } else if (currentState is WishlistScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }
          return buildUI(wishlistModel?.wishLists, context);
        }));
  }

  Widget buildUI(List<WishListItems>? items, BuildContext context) {
    return isLoading
        ? Loader()
        : Visibility(
            visible: wishlistModel != null,
            child: (wishlistModel?.wishLists ?? []).isEmpty ||
                    wishlistModel?.wishlistCount == 0
                ? lottieAnimation(
                    context,
                    "lib/assets/lottie/empty_wishlist.json",
                    _localizations?.translate(AppStringConstant.noItems) ?? "",
                    _localizations
                            ?.translate(AppStringConstant.noItemsInWishlist) ??
                        "",
                    _localizations
                            ?.translate(AppStringConstant.continueShopping) ??
                        "", () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(navBar, (route) => false);
                  })
                : Padding(
                    padding: const EdgeInsets.all(AppSizes.imageRadius),
                    child: buildWishlistView(items, context)));
  }

  Widget buildWishlistView(List<WishListItems>? items, BuildContext context) {
    return Stack(children: [
      GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (((AppSizes.width / 2.5) - AppSizes.linePadding)/((AppSizes.width / 2.5) + (AppSizes.linePadding * 4) + 40)),
          ),
          itemCount: items?.length,
          itemBuilder: (BuildContext context, int index) {
            var imageSize = (AppSizes.width / 2.5) - AppSizes.linePadding;
            return Stack(children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageView(
                              url: items?[index].thumbNail,
                              height: imageSize,
                              width: imageSize,
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.linePadding,
                                    vertical: AppSizes.linePadding),
                                child: Text(
                                  items?[index].name ?? "",
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(fontSize: 13),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.linePadding),
                              child: Text(
                                items?[index].priceUnit ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.linePadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: AppSizes.width,
                                  height: 30,
                                  child: TextButton(
                                      onPressed: () {
                                        wishlistScreenBloc
                                            ?.emit(WishlistActionState());
                                        wishlistScreenBloc?.add(MoveToCartEvent(
                                            items?[index].name ?? "",
                                            items?[index].id ?? 0,
                                            items?[index].productId ?? 0));
                                      },
                                      child: Text(
                                        _localizations?.translate(
                                                AppStringConstant.moveToCart) ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, productPage, arguments: getProductDataMap(items?[index].name ?? "", items?[index].templateId.toString() ?? ''));
                },
              ),
              Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: GestureDetector(
                    onTap: () {
                      DialogHelper.confirmationDialog(
                          AppStringConstant.removeItemFromWishlist,
                          context,
                          _localizations, onConfirm: () {
                        wishlistScreenBloc?.emit(WishlistActionState());
                        wishlistScreenBloc?.add(
                            RemoveItemEvent(items?[index].productId ?? 0));
                      });
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                          )),
                      child: const Icon(
                        Icons.close,
                        size: 17,
                      ),
                    ),
                  ))
            ]);
          }),
      Center(
          child: Visibility(
        visible: isAction,
        child: Loader(),
      )),
    ]);
  }
}
