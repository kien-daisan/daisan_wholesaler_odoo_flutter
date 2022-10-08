import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

class HomePromotionalBanners extends StatefulWidget {
  List<BannerImages> banners = [];

  HomePromotionalBanners(this.banners);

  @override
  _HomePromotionalBannersState createState() => _HomePromotionalBannersState();
}

class _HomePromotionalBannersState extends State<HomePromotionalBanners> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  AppLocalizations? _localizations;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.banners.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage,
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
          height: AppSizes.width / 2.5,
          width: AppSizes.width.toDouble(),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.linePadding),
                        child: Image.network(
                          widget.banners[index].url ?? "",
                          fit: BoxFit.fill,
                          height: AppSizes.width / 3,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.imageRadius),
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
          ),
        ),
      ],
    );
  }
}
