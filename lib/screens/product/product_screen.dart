// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
import 'package:flutter_project_structure/screens/product/views/add_to_cart_button.dart';
import 'package:flutter_project_structure/screens/product/views/alternate_products.dart';
import 'package:flutter_project_structure/screens/product/views/product_basic_details.dart';
import 'package:flutter_project_structure/screens/product/views/product_details.dart';
import 'package:flutter_project_structure/screens/product/views/product_images.dart';
import 'package:flutter_project_structure/screens/product/views/product_variants.dart';
import 'package:flutter_project_structure/screens/product/views/quantity_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/arguments_map.dart';
import '../../customWidgtes/app_bar.dart';
import '../../helper/app_shared_pref.dart';
import '../../utils/helper.dart';

class ProductScreen extends StatefulWidget {
  Map<String, dynamic> arguments;

  ProductScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  ProductScreenBloc? productPageBloc;
  ProductScreenModel? productPageData;
  AppLocalizations? _localizations;
  bool isLoading = false;
  int? counter = 1;
  bool? addedToWishlist = false;
  BaseModel? baseModel;

  @override
  void initState() {
    productPageBloc = context.read<ProductScreenBloc>();
    productPageBloc
        ?.add(ProductScreenDataFetchEvent(widget.arguments[productIdKey]));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductScreenBloc, ProductScreenState>(
      builder: (context, currentState) {
        if (currentState is ProductScreenInitial) {
          isLoading = true;
        } else if (currentState is ProductScreenSuccess) {
          productPageData = currentState.productPageData;
          isLoading = false;
          addedToWishlist = productPageData?.addedToWishlist ?? false;
        } else if (currentState is ProductScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        } else if (currentState is QuantityUpdateState) {
          isLoading = false;
          counter = currentState.qty;
        } else if (currentState is AddToWishlistState) {
          isLoading = false;
          baseModel = currentState.baseModel;
          if (currentState.baseModel?.success ?? false) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel?.message ?? '', context);
            });
            addedToWishlist = true;
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel?.message ?? '', context);
            });
          }
        } else if (currentState is RemoveFromWishlist) {
          isLoading = false;
          baseModel = currentState.baseModel;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.baseModel?.message ?? '', context);
          });
          addedToWishlist = false;
        } else if (currentState is AddtoCartState) {
          isLoading = false;
          baseModel = currentState.model;

          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.model?.message ?? '', context);
          });
        } else if (currentState is BuyNowState) {
          isLoading = false;
          baseModel = currentState.model;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushNamed(context, cart);
          });
        } else if (currentState is AddReview) {
          isLoading = false;
          baseModel = currentState.baseModel;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.baseModel?.message ?? '', context);
          });
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: commonAppBar(
          productPageData?.name ?? widget.arguments[productNameKey] ?? "",
          context,
          actions: [
            if (AppSharedPref().getIfLogin() ?? false)
              IconButton(
                  onPressed: () {
                    // startArActivity();
                    Navigator.pushNamed(context, wishlist).then((value) {
                      productPageBloc?.emit(ProductScreenInitial());
                      productPageBloc?.add(ProductScreenDataFetchEvent(
                          widget.arguments[productIdKey]));
                    });
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    // color: Theme.of(context).iconTheme.color,
                  )),
            IconButton(
                onPressed: () {
                  if (AppSharedPref().getIfLogin() != null &&
                      AppSharedPref().getIfLogin() == true) {
                    Navigator.pushNamed(context, cart);
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
                icon: BadgeIcon(
                  icon: Icon(Icons.shopping_cart),
                )),
          ]),
      body: Stack(
        children: [
          Visibility(
              visible: (productPageData?.success ?? false),
              child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ProductImages(productPageData?.images ?? []),
                                  if (getArStatus())
                                    InkWell(
                                      child: Icon(Icons.border_clear_rounded),
                                      onTap: () => startArActivity(),
                                    )
                                ],
                              ),
                              ProductPageBasicDetailsView(
                                addedToWishlist!,
                                productPageBloc,
                                product: productPageData,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: AppSizes.normalPadding,
                      ),
                      if ((productPageData?.variants ?? []).isNotEmpty)
                        ProductVariants(productPageData!, productPageBloc),
                      SizedBox(
                        height: AppSizes.normalPadding,
                      ),
                      QuantityView(
                        bloc: productPageBloc,
                        counter: counter,
                      ),
                      SizedBox(
                        height: AppSizes.normalPadding,
                      ),

                      Visibility(
                        visible: productPageData?.addToCart ?? false,
                        child: AddToCartButtonView(
                            productPageBloc,
                            productPageData?.productId ?? 0,
                            productPageData?.name ?? '',
                            counter!),
                      ),
                      ProductDetailsView(productPageData?.description),
                      // ProductMoreInformation(),
                      if ((AppSharedPref().getSplashData()?.addons?.review ??
                              false) &&
                          (productPageData?.totalReview ?? 0) > 0)
                        reviewTile(),

                      AlternateProductsList(
                          productPageData?.alternativeProducts),
                    ],
                  ))),
          Visibility(visible: isLoading, child: Loader())
        ],
      ),
    );
  }

  Widget reviewTile() {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(reviewList,
              arguments: getReviewDataMap(
                  productPageData?.name ?? "",
                  productPageData?.thumbNail ?? "",
                  productPageData?.templateId ?? 0))
          .then((value) {
        productPageBloc?.emit(ProductScreenInitial());
        productPageBloc
            ?.add(ProductScreenDataFetchEvent(widget.arguments[productIdKey]));
      }),
      child: Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.sidePadding, horizontal: AppSizes.imageRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " ${_localizations?.translate(AppStringConstant.reviews)} (${productPageData?.totalReview})",
                style: Theme.of(context).textTheme.headline3,
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          )),
    );
  }

  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future startArActivity() async {
    if (Platform.isIOS) {
      Helper().downloadPersonalData(context, productPageData?.arIos ?? "");
    }
    var isGranted = await Permission.storage.isGranted;
    if (isGranted) {
      try {
        var data = await methodChannel.invokeMethod("showAr",
            {"name": productPageData?.name, "url": productPageData?.arAndroid});
        return data;
      } on PlatformException catch (e) {
        return "Failed to Invoke: '${e.message}'.";
      }
    } else {
      Permission.storage.request();
    }
    print("hhhjihiuh---${productPageData?.arAndroid}");
  }

  bool getArStatus() {
    if (Platform.isAndroid && (productPageData?.arAndroid ?? "").isNotEmpty) {
      return false;
    } else if (Platform.isIOS &&
        (productPageData?.arAndroid ?? "").isNotEmpty) {
      return true;
    }
    return false;
  }
}
