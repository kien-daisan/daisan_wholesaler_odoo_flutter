// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:flutter_project_structure/helper/image_view.dart';
// import 'package:flutter_project_structure/models/HomeScreenModel.dart';
//
// class ListItem extends StatefulWidget {
//   Product? product;
//
//   ListItem({this.product});
//
//   @override
//   _ListItemState createState() => _ListItemState();
// }
//
// class _ListItemState extends State<ListItem> {
//   AppLocalizations? _localizations;
//   double imageSize = 0.0;
//
//   @override
//   void didChangeDependencies() {
//     _localizations = AppLocalizations.of(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     imageSize = (MediaQuery.of(context).size.width / 2.5);
//     return Card(
//       elevation: 4.0,
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           productImage(
//               imageUrl:
//                   "https://static.toiimg.com/photo/msid-86481241/86481241.jpg",
//               isNew: true),
//           productDetail(
//               productName: widget.product?.name,
//               productPrice: widget.product?.price,
//               isInWishList: true)
//         ],
//       ),
//     );
//   }
//
//   Widget productImage({String? imageUrl, bool? isNew}) {
//     return Stack(children: <Widget>[
//       ImageView(url: imageUrl, height: imageSize - 3, width: imageSize),
//       Positioned(
//           left: 0,
//           top: 8,
//           child: Container(
//             color: Colors.green,
//             child: const Padding(
//               padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
//               child: Text(
//                 "New",
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ))
//     ]);
//   }
//
//   Widget productDetail(
//       {String? productName,
//       String? productPrice,
//       bool isInWishList = false,
//       double rating = 0.0}) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Container(
//         // color: Colors.black26,
//         width: ((MediaQuery.of(context).size.width - 32) - imageSize),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(productPrice ?? '',
//                     style: Theme.of(context).textTheme.bodyText1),
//                 Spacer(),
//                 InkWell(
//                   onTap: (){
//                     setState(() {
//                       isInWishList = !isInWishList;
//                     });
//                   },
//                     child: Icon(
//                   isInWishList ? Icons.favorite : Icons.favorite_border,
//                   color: isInWishList ? Colors.red : Colors.grey,
//                 )),
//               ],
//             ),
//             SizedBox(
//               height: 8.0,
//             ),
//             Row(
//               children: [
//                 Text(
//                   productName ?? '',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             (rating > 0.0)
//                 ? Container()
//                 : Text(_localizations?.translate('No Reviews Yet') ?? '')
//           ],
//         ),
//       ),
//     );
//   }
// }
