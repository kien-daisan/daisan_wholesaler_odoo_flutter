import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

class HomeBanners extends StatefulWidget {
  List<BannerImages> banners = [];

  HomeBanners(this.banners);

  @override
  _HomeBannersState createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  AppLocalizations? _localizations;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPageNotifier.value < widget.banners.length) {
        _currentPageNotifier.value++;
      } else {
        _currentPageNotifier.value = 0;
      }

      _pageController.animateToPage(_currentPageNotifier.value,
          duration: const Duration(milliseconds: 60), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left:AppSizes.imageRadius, top: AppSizes.imageRadius ),
        //   child: Text(_localizations?.translate(AppStringConstant.offers) ?? "",
        //   style: Theme.of(context).textTheme.headline3,),
        // ),
        Container(
          padding: const EdgeInsets.only(top: AppSizes.imageRadius),
          height: AppSizes.width / 2,
          width: AppSizes.width.toDouble(),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => handleBannerClicks(widget.banners[index], context),
                child: Card(
                    margin: EdgeInsets.zero,
                    child: ImageView(
                      url: widget.banners[index].url ?? "",
                      fit: BoxFit.fill,
                    )),
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPageNotifier.value = index;
              });
            },
          ),
        ),
        Center(
          child: _buildCircularindicator(_currentPageNotifier),
        )
      ],
    );
  }

  Widget _buildCircularindicator(_currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor:
            Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.banners.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  void handleBannerClicks(BannerImages banner, BuildContext context) {
    if (banner.bannerType == AppConstant.categoryTypeNotification) {
      Navigator.pushNamed(context, catalogPage,
          arguments: getCatalogMap(
            "",
            false,
            banner.bannerName ?? "",
            customerId: banner.id,
          ));
    } else if (banner.bannerType == AppConstant.productTypeNotification) {
      Navigator.pushNamed(context, productPage,
          arguments: getProductDataMap(banner.bannerName ?? "", banner.id.toString()));
    } else if (banner.bannerType == AppConstant.customTypeNotification) {
      Navigator.pushNamed(context, catalogPage,
          arguments: getCatalogMap("", false, "Catalog",
              fromNotification: true, domain: banner.domain ?? ""));
    }
  }
}
