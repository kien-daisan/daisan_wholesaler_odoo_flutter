import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/category/widgets/view_card.dart';

class CategoryTile extends StatefulWidget {
  List<Categories>? subCategories;

  CategoryTile({Key? key, this.subCategories}) : super(key: key);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.subCategories?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if ((widget.subCategories?[index].children ?? []).isEmpty) {
            //=============If no child's are found=========//
            return ListTile(
              title: Text(
                widget.subCategories?[index].name ?? "",
                style:  Theme.of(context).textTheme.headline6,
              ),
              trailing: const Icon(Icons.arrow_right),
              onTap: (){
                Navigator.of(context).pushNamed(catalogPage,arguments:getCatalogMap( "", false,widget.subCategories?[index].name ?? "",customerId: widget.subCategories?[index].categoryId ?? 0));
              },
            );
          }
          return ExpansionTile(
              //==========If sub category have child's=============//
              initiallyExpanded: false,
              title: Text(
                widget.subCategories?[index].name ?? "",
                style:  Theme.of(context).textTheme.headline6,
              ),
              children: [
                if (widget.subCategories?[index].children != null)
                  Container(
                      child: expandedTileContent(index))
              ]);
        });
  }

  //=========View after tile expansion===========//
  Widget expandedTileContent(int index) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 - (130 / MediaQuery.of(context).size.width)),
        ),
        itemCount: (widget.subCategories?[index].children?.length ?? 0) + 1,
        itemBuilder: (BuildContext context, int itemIndex) {
          if (itemIndex ==
              (widget.subCategories?[index].children?.length ?? 0)) {
            return  ViewCard(widget.subCategories?[index].categoryId,widget.subCategories?[index].name ?? "");
          }
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(catalogPage,
                  arguments: getCatalogMap("", false,widget.subCategories?[index].children?[itemIndex].name ?? "",customerId: widget.subCategories?[index].children?[itemIndex].categoryId ?? 0, ));

            },
            child: Column(
              children: [
                ImageView(
                  url: widget.subCategories?[index].children?[itemIndex].icon,
                  height: AppSizes.height/7,
                  width: AppSizes.width/7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.subCategories?[index].children?[itemIndex].name ?? "",

                  ),
                )
              ],
            ),
          );
        });
  }
}
