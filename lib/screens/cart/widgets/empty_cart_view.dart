// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/constants/route_constant.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../constants/app_constants.dart';
// import '../../../constants/app_string_constant.dart';
//
// Widget emptyCartView(AppLocalizations? _localizations, BuildContext context) {
//   return Center(
//     child: Container(
//       height: AppSizes.height / 2,
//       width: AppSizes.width - 50,
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         border: Border.all(width: 1.0, color: Theme.of(context).cardColor),
//       ),
//       child: Column(children: [
//         Lottie.asset("lib/assets/lottie/empty_cart.json",
//             width: AppSizes.width / 2,
//             height: AppSizes.height / 3.5,
//             fit: BoxFit.fill,
//         repeat:  false),
//         Text(_localizations?.translate(AppStringConstant.emptyCart) ?? "",
//             style: Theme.of(context).textTheme.headline3),
//         const Padding(padding: EdgeInsets.all(AppSizes.linePadding)),
//         Text(
//           _localizations?.translate(AppStringConstant.noItemsInCart) ?? "",
//           style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
//         ),
//         const Padding(padding: EdgeInsets.all(AppSizes.imageRadius)),
//         ElevatedButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil(navBar, (route) => false);
//             },
//             style: ElevatedButton.styleFrom(primary: AppColors.black),
//             child: Text(
//               _localizations?.translate(AppStringConstant.continueShopping) ??
//                   "",
//               style: const TextStyle(color: AppColors.white),
//             ))
//       ]),
//     ),
//   );
// }
