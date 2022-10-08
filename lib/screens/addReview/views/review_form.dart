// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';
// import 'package:flutter_project_structure/constants/app_string_constant.dart';
// import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
// import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
// import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
// import 'package:flutter_project_structure/customWidgtes/rating_bar.dart';
// import 'package:flutter_project_structure/helper/alert_message.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:flutter_project_structure/helper/image_view.dart';
//
// Widget reviewForm(String name, String thumbNail, BuildContext context,
//     AppLocalizations? _localizations, Function(int, String, String)? callback) {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController reviewTitle = TextEditingController();
//   TextEditingController reviewDetail = TextEditingController();
//   double rating = 0.0;
//
//   return Scaffold(
//     appBar: commonToolBar(_localizations?.translate(AppStringConstant.addReviews) ?? "", context,isElevated : false),
//     body: Container(
//       height: AppSizes.height - AppBar().preferredSize.height,
//       padding: const EdgeInsets.all(AppSizes.imageRadius),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.fromLTRB(AppSizes.linePadding, 0.0,
//                         AppSizes.widgetSidePadding, 0.0),
//                     child: SizedBox(
//                         height: AppSizes.height / 5,
//                         width: AppSizes.width / 4,
//                         child: ImageView(url: thumbNail))),
//                 Expanded(
//                     child: Text(name,
//                         maxLines: 2,
//                         style: Theme.of(context).textTheme.headline4))
//               ],
//             ),
//             const Divider(
//               thickness: 1.0,
//             ),
//             const SizedBox(
//               height: AppSizes.imageRadius,
//             ),
//             Text(_localizations?.translate(AppStringConstant.rating) ?? "",
//                 style: Theme.of(context).textTheme.headline4),
//             const SizedBox(
//               height: AppSizes.imageRadius,
//             ),
//             RatingBar(
//               starCount: 5,
//               color: AppColors.yellow,
//               rating: rating,
//               onRatingChanged: (_rating) {
//                 rating = _rating;
//                 print('rating changed ---- $_rating');
//               },
//             ),
//             const SizedBox(
//               height: AppSizes.genericPadding,
//             ),
//             Form(
//               key: _formKey,
//               child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 CommonTextField(
//                   controller: reviewTitle,
//                   isPassword: false,
//                   hintText: _localizations
//                           ?.translate(AppStringConstant.WriteReviewTitle) ??
//                       "",
//                   isRequired: true,
//                 ),
//                 const SizedBox(
//                   height: AppSizes.linePadding,
//                 ),
//                 CommonTextField(
//                     controller: reviewDetail,
//                     isPassword: false,
//                     hintText: _localizations
//                             ?.translate(AppStringConstant.Writeyourreview) ??
//                         "",
//                     isRequired: true),
//               ]),
//             ),
//             const SizedBox(
//               height: AppSizes.imageRadius,
//             ),
//             commonButton(context, () {
//               if (_formKey.currentState!.validate() && rating != 0.0) {
//                 callback!(
//                     rating.toInt(), reviewTitle.text, reviewDetail.text);
//               } else if (rating == 0.0) {
//                 AlertMessage.showError(_localizations?.translate(AppStringConstant.selectRating) ?? "", context);
//               }
//             },
//                 (_localizations?.translate(AppStringConstant.submit) ?? "").toUpperCase(),
//               backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                 textColor: Theme.of(context).colorScheme.secondaryContainer
//
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
