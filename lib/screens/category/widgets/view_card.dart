import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';

class ViewCard extends StatelessWidget {
  int? cid;
  String categoryName;
  ViewCard(this.cid,this.categoryName, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(catalogPage, arguments:getCatalogMap( "", false,categoryName,customerId: cid!));
      },
      child:
      Column(
        children: [
          ImageView(
            height: AppSizes.height/7,
            width: AppSizes.width/7,
          ),
          Text(
              "${AppLocalizations.of(context)?.translate(AppStringConstant.viewAll)}",)
        ],
      ),
    );
  }
}
