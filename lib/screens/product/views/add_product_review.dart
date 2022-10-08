// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';
// import 'package:flutter_project_structure/constants/app_string_constant.dart';
// import 'package:flutter_project_structure/customWidgtes/rating_bar.dart';
// import 'package:flutter_project_structure/helper/alert_message.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:flutter_project_structure/helper/image_view.dart';
// import '../../../customWidgtes/common_text_field.dart';
// import '../../../customWidgtes/common_tool_bar.dart';
//
// Future addReview(BuildContext context,String name, String thumbNail, Function(int, String, String)? callback,AppLocalizations? _localizations){
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController reviewTitle = TextEditingController();
//   TextEditingController reviewDetail = TextEditingController();
//   bool? isLoading = false;
//   double rating = 0.0;
//   return showModalBottomSheet(
//     isScrollControlled: true,
//       context: context,
//       builder: (context){
//         return SingleChildScrollView(
//           child: Container(
//             height: AppSizes.height-10,
//             padding: const EdgeInsets.all(AppSizes.imageRadius),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 commonToolBar(_localizations?.translate(AppStringConstant.addReviews) ?? "", context,isElevated : false,isLeadingEnable: true),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.fromLTRB(AppSizes.linePadding, 0.0, AppSizes.widgetSidePadding, 0.0),
//                         child: SizedBox(
//                             height:AppSizes.height / 5,
//                             width:AppSizes.width / 4,
//                             child: ImageView(url: thumbNail)
//                         )),
//                      Expanded(child:  Text(name,
//                       maxLines: 2,
//                       style: Theme.of(context).textTheme.headline4))
//                   ],
//                 ),
//                 const Divider(
//                   thickness: 1.0,
//
//                     ),
//                     const SizedBox(height:AppSizes.imageRadius,),
//                      Text(_localizations?.translate(AppStringConstant.rating) ?? "", style:  Theme.of(context).textTheme.headline4
//
//                    ),
//                     const SizedBox(height: AppSizes.imageRadius,),
//                     RatingBar(starCount: 5,color: AppColors.yellow,rating: rating,onRatingChanged: (_rating){
//                       rating = _rating;
//                     },),
//                     const SizedBox(height: AppSizes.genericPadding,),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CommonTextField(controller: reviewTitle,
//                               isPassword: false,
//                               hintText: _localizations?.translate(AppStringConstant.WriteReviewTitle) ?? "",
//                               helperText: " ",
//                               isRequired: true,),
//                             const SizedBox(height: AppSizes.linePadding,),
//                             CommonTextField(controller: reviewDetail,
//                                 isPassword: false,
//                                 hintText: _localizations?.translate(AppStringConstant.Writeyourreview) ?? "",
//                                 helperText: "",
//                                 isRequired: true),
//                           ]),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.only(top: 0, bottom: 0),
//
//                       child:ConstrainedBox(
//                           constraints: const BoxConstraints.tightFor(height: 50),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               primary: AppColors.black
//                             ),
//                             child:  Text(_localizations?.translate(AppStringConstant.submit) ?? "",
//                               style: const TextStyle(
//                                 color: AppColors.white
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate() && rating != 0.0) {
//                                 callback!(rating.toInt(), reviewTitle.text, reviewDetail.text);
//                               }else if(rating == 0.0){
//                                 AlertMessage.showError(_localizations?.translate(AppStringConstant.selectRating) ?? "", context);
//                               }
//                             },
//                           )
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         );
// }