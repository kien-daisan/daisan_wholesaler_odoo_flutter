import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/screens/home/views/item_brands.dart';

import '../../../helper/image_view.dart';
import '../../../models/HomeScreenModel.dart';

class HomeBrands extends StatelessWidget {
  List<BannerImages>? brands;
  HomeBrands(this.brands);

  @override
  Widget build(BuildContext context) {
    return brandsCollection(context, brands);
  }

  Widget brandsCollection(BuildContext context, List<BannerImages>? brands) {
    return Card(
      elevation: 4.0,
      color: Theme.of(context).colorScheme.background,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Theme.of(context).colorScheme.background,
          child: _buildDealList(context, brands)),
    );
  }

  Widget _buildDealList(BuildContext context, List<BannerImages>? brands) {
    Random random = Random();
    int viewType = random.nextInt(2);
    switch (viewType) {
      case 1:
        return gridViewBrand(context, brands);
      default:
        return brandsListHorizontalView(context, brands);
    }
  }

  Widget brandsListHorizontalView(
      BuildContext context, List<BannerImages>? brands) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 95.0,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: brands?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var data = brands?[index];
                return GestureDetector(
                  onTap: () {},
                  child: BrandView(data!),
                );
              }),
        ),
      ],
    );
  }

  Widget gridViewBrand(BuildContext context, List<BannerImages>? brands) {
    return Column(
      children: [
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (1 - (90 / MediaQuery.of(context).size.width)),
            ),
            //itemCount: widget.products?.length ?? 0,
            itemCount: brands?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              var data = brands?[index];
              return GestureDetector(
                onTap: () {},
                child: BrandView(data!),
              );
            }),
      ],
    );
  }
}
