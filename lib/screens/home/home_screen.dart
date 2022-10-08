import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/helper/push_notifications_manager.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/views/home_banners.dart';
import 'package:flutter_project_structure/screens/home/views/home_brands.dart';
import 'package:flutter_project_structure/screens/home/views/home_collection_view.dart';
import 'package:flutter_project_structure/screens/home/views/home_featured_categories.dart';
import 'package:flutter_project_structure/screens/home/views/home_promotional_banners.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState state = _HomeScreenState();

  @override
  _HomeScreenState createState() {
    return this.state = _HomeScreenState();
  }

  List<Categories>? getData() {
    return state.getData();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc? homePageBloc;
  AppLocalizations? _localizations;
  bool isLoading = true;
  HomePageData? homePageData;

  @override
  void initState() {
    homePageBloc = context.read<HomeScreenBloc>();
    homePageBloc?.add(HomeScreenDataFetchEvent());
    PushNotificationsManager().checkInitialMessage(context);
    printTokne();
    super.initState();
  }

  void printTokne() async {
  print("token>>"+((await FirebaseMessaging.instance.getToken()) ?? ""));

  print("device_id" +((await DeviceInfoPlugin().androidInfo).androidId ?? "") );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  List<Categories>? getData() {
    if (homePageData != null) {
      return homePageData?.categories;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkForDeepLink().then((value) => print("asdasdas--$value"));
    return Scaffold(
      appBar: commonAppBar(
          _localizations?.translate(AppStringConstant.APPNAME) ?? '', context,
          isHomeEnable: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, searchPage);
                },
                icon: const Icon(Icons.search,
                   ),),
            IconButton(
                onPressed: () {
                  notificationBottomModelSheet(context);
                },
                icon: const Icon(Icons.notifications,
                    ))
          ]),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, currentState) {
          if (currentState is HomeScreenInitial) {
            isLoading = true;
          } else if (currentState is HomeScreenSuccess) {
            homePageData = currentState.homePageData;
            isLoading = false;
          } else if (currentState is HomeScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }
          return _buildUI();
        },
      ),
      // drawer: _fetchDrawerData(context),
      // bottomNavigationBar: const BottomNavigationBarView(),
    );
  }

  final ScrollController _scrollController = ScrollController();

  Widget _buildUI() {
    return Stack(
          children: [
            RefreshIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
              onRefresh: () {
                return Future.delayed(Duration.zero).then((value) {
                  homePageBloc?.add(HomeScreenDataFetchEvent());
                });
              },
              child: Visibility(
                  visible:
                      ((homePageData?.productSliders?.isNotEmpty ?? false) && (homePageData?.productSliders?[0].products?.length ?? 0) > 0),
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          HomeFeaturedCategories(
                              homePageData?.featuredCategories ?? []),
                          HomeBanners(homePageData?.bannerImages ?? []),
                          HomeCollection(
                            products: homePageData?.productSliders,
                          ),
                          _buildReachBottomView()
                        ],
                      ))),
            ),
            Visibility(
                visible: isLoading,
                child: Loader())
          ],
        );
  }

  Widget _buildReachBottomView() {
    return Container(
      width: AppSizes.width.toDouble(),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
      padding: const EdgeInsets.only(
          top: AppSizes.sidePadding,
          bottom: (AppSizes.sidePadding + AppSizes.sidePadding)),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "${AppLocalizations.of(context)?.translate(AppStringConstant.reachedBottom)}"),
          TextButton(
              onPressed: () {
                _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              child: Text(
                "${AppLocalizations.of(context)?.translate(AppStringConstant.backToTop)}",
                style: Theme.of(context).textTheme.bodyText1,
              )),
        ],
      ),
    );
  }

  //=========Handle Deep Linking=========//
  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future<String> checkForDeepLink() async {
    try {
      var data = await methodChannel.invokeMethod('initialLink');
      if (data.toString().contains("product")) {
        var splitData = data.toString().split("-");
        Navigator.of(context).pushNamed(productPage,
            arguments: getProductDataMap("", splitData.last));
      }
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}
