//
// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';
// import 'package:flutter_project_structure/constants/app_string_constant.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:lottie/lottie.dart';
//
// Widget emptyOrderListView(AppLocalizations? _localizations, BuildContext context) {
//   return Center(
//     child: Container(
//       height: AppSizes.height / 2,
//       width: AppSizes.width - 50,
//       decoration: BoxDecoration(
//         border: Border.all(width: 1.0, color: AppColors.background),
//       ),
//       child: Column(children: [
//         Lottie.asset("lib/assets/lottie/empty_order_list.json",
//             width: AppSizes.width / 2,
//             height: AppSizes.height / 3.5,
//             fit: BoxFit.fill,
//             repeat: false
//         ),
//         Text(_localizations?.translate(AppStringConstant.noOrder) ?? "",
//             style: Theme.of(context).textTheme.headline3),
//
//       ]),
//     ),
//   );
// }
