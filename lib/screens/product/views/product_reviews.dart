import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/models/ReviewListModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
import 'package:flutter_project_structure/screens/product/bloc/review_screen_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/review_screen_state.dart';
import 'package:flutter_project_structure/screens/product/views/product_review_circle.dart';
import 'package:flutter_project_structure/screens/product/views/rating_container.dart';
import 'package:flutter_project_structure/screens/product/views/review_list_item_card.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/arguments_map.dart';
import '../../../constants/route_constant.dart';
import '../../../customWidgtes/dialog_helper.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_shared_pref.dart';
import '../../../helper/loader.dart';
import '../../../helper/open_bottom_model_sheet.dart';

class ProductReview extends StatefulWidget {
  Map<String, dynamic>? productDetails;

  ProductReview({Key? key, this.productDetails}) : super(key: key);

  @override
  _ProductReviewState createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  ReviewScreenBloc? reviewPageBloc;
  AppLocalizations? _localizations;
  bool isLoading = false;
  ReviewListModel? reviewsData;
  bool isFromReview = false;

  @override
  void initState() {
    reviewPageBloc = context.read<ReviewScreenBloc>();
    reviewPageBloc?.add(ReviewsDataFetchEvent(
        widget.productDetails?[templateIdKey].toString()));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          _localizations?.translate(AppStringConstant.reviews) ?? "", context),
      body: BlocBuilder<ReviewScreenBloc, ReviewScreenState>(
        builder: (context, currentState) {
          if (currentState is ReviewScreenInitial) {
            if (!isFromReview) {
              isLoading = true;
            }
          } else if (currentState is ReviewScreenSuccess) {
            reviewsData = currentState.reviewsData;
            isLoading = false;
          } else if (currentState is ReviewScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          } else if (currentState is LikeDislikeReviewSuccess) {
            print('wqdqwdqwda');
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (currentState.baseModel?.success == true) {
                AlertMessage.showSuccess(
                    currentState.baseModel?.message ?? '', context);
                reviewPageBloc?.add(ReviewsDataFetchEvent(
                    widget.productDetails?[templateIdKey].toString()));
              } else {
                isLoading = false;
                isFromReview = false;
                AlertMessage.showError(
                    currentState.baseModel?.message ?? '', context);
              }
            });
          }
          return _buildUI();
        },
      ),
    );
  }

  Widget _buildUI() {
    return isLoading
        ? Loader()
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Theme.of(context).cardColor,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.widgetSidePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [const ProductReviewCircle(), productRating()],
                  ),
                ),
                productReviewList(reviewsData?.productReviews)
              ]),
            ),
          );
  }

  Widget productReviewList(List<ProductReviews>? productReviews) {
    return ((productReviews != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.normalPadding,
                horizontal: AppSizes.imageRadius),
            child: ListView.builder(
                itemCount: productReviews.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = productReviews[index];
                  return reviewListItemCard(
                      data,
                      context,
                      likeDislikeFunction(data.id.toString(), true),
                      likeDislikeFunction(data.id.toString(), false));
                }),
          )
        : Container());
  }

  GestureTapCallback likeDislikeFunction(String reviewId, bool isHelpful) =>
      () {
        if (AppSharedPref().getIfLogin() != null &&
            AppSharedPref().getIfLogin() == true) {
          isFromReview = true;
          reviewPageBloc?.add(ReviewLikeDislikeEvent(reviewId, isHelpful));
          reviewPageBloc?.emit(ReviewScreenInitial());
        }
      };

  Widget productRating() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     RatingContainer(3.0),
      //   ],
      // ),
      Container(
        padding: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Text(_localizations?.translate(AppStringConstant.basedOn) ?? '',
            style: Theme.of(context).textTheme.bodyText1),
      ),
      Container(
        padding: const EdgeInsets.only(top: AppSizes.linePadding),
        child: Text(
            '${reviewsData?.reviewCount} ${_localizations?.translate(AppStringConstant.reviews) ?? ''}',
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 12)),
      ),
      Container(
        padding: const EdgeInsets.only(top: AppSizes.normalPadding),
        child: GestureDetector(
          onTap: () {
            if (AppSharedPref().getIfLogin() != null &&
                AppSharedPref().getIfLogin() == true) {
              reviewBottomModalSheet(
                  context,
                  widget.productDetails?[productNameKey],
                  widget.productDetails?[productImageKey],
                  widget.productDetails?[templateIdKey], function: () {
                reviewPageBloc?.emit(ReviewScreenInitial());
                reviewPageBloc?.add(ReviewsDataFetchEvent(
                    widget.productDetails?[templateIdKey].toString()));
              });
            } else {
              DialogHelper.confirmationDialog(
                  "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                  context,
                  _localizations, onConfirm: () async {
                Navigator.pushNamed(context, loginSignup, arguments: false);
              });
            }
          },
          child: Text(
              _localizations?.translate(AppStringConstant.addReview) ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColors.textBlue, fontSize: 12)),
        ),
      ),
    ]);
  }
}
