import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/catalog/bloc/catalog_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/views/product_item_full_width.dart';
import 'package:flutter_project_structure/screens/home/views/product_list_widgets/product_list_widgets.dart';
import 'package:provider/src/provider.dart';

import '../../constants/arguments_map.dart';

class CatalogScreen extends StatefulWidget {
  Map<String, dynamic> catalogScreenPassData;

  CatalogScreen(this.catalogScreenPassData);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ScrollController _scrollController = ScrollController();
  AppLocalizations? _localizations;
  String imageUrl = '';
  bool isLoading = true;
  bool isGridViewShowing = true;
  CatalogScreenBloc? catalogScreenBloc;
  CategoryScreenModel? model;
  int offset = 0;
  bool isFromPagination = false;
  List<Products> productList = [];
  StreamController<bool>? fabIcon;
  StreamController<bool>? buildScreen;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    catalogScreenBloc = context.read<CatalogScreenBloc>();

    if (widget.catalogScreenPassData[fromNotificationKey]) {
      catalogScreenBloc?.add(CatalogScreenDataFetchFromNotificationEvent(
          10, widget.catalogScreenPassData[domainKey]));
    } else {
      widget.catalogScreenPassData[fromHomePageKey]
          ? catalogScreenBloc?.add(CatalogScreenDataFetchFromHomeEvent(
              widget.catalogScreenPassData[urlKey], 10, 0))
          : catalogScreenBloc?.add(CatalogScreenDataFetchEvent(
              widget.catalogScreenPassData[customerIdKey], 10, 0));
    }

    fabIcon = StreamController<bool>();
    buildScreen = StreamController<bool>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
           widget.catalogScreenPassData[categoryNameKey],
          context,
          isElevated: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, searchPage);
                },
                icon: const Icon(Icons.search))
          ]),
      body: BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
          builder: (context, state) {
        if (state is CatalogScreenInitialState) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (state is CatalogScreenSuccessState) {
          model = state.categoryScreenModel;
          if (offset == 0) {
            productList = model?.products ?? [];
          } else {
            productList.addAll(model?.products ?? []);
          }
          isLoading = false;
          isFromPagination = false;
        } else if (state is CatalogDataFromNotificationSuccessState) {
          isLoading = false;
          model = state.categoryScreenModel;
          productList = model?.products ?? [];
        } else if (state is CatalogScreenErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? '', context);
          });
        }
        return isLoading
            ? Loader()
            : Visibility(
                visible: model?.products?.isNotEmpty ?? true,
                child: SingleChildScrollView(
                    controller: _scrollController
                      ..addListener(() {
                        paginationFunction();
                      }),
                    child: StreamBuilder(
                        stream: buildScreen?.stream,
                        builder: (context, snapshot) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.imageRadius),
                            child: Column(
                              children: [
                                isGridViewShowing
                                    ? buildGridProduct(
                                        productList, _localizations,
                                        isCatalog: true)
                                    : listView(productList),
                                Visibility(
                                    visible: isFromPagination, child: Loader())
                              ],
                            ),
                          );
                        })),
              );
      }),
      floatingActionButton: StreamBuilder(
          stream: fabIcon?.stream,
          builder: (context, snapshot) {
            print('------${snapshot.data}');
            return FloatingActionButton(
              backgroundColor:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              child: isGridViewShowing
                  ? Icon(
                      Icons.list,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    )
                  : Icon(Icons.grid_view,
                      color: Theme.of(context).colorScheme.secondaryContainer),
              onPressed: () {
                isGridViewShowing = !isGridViewShowing;
                fabIcon?.sink.add(isGridViewShowing);
                buildScreen?.sink.add(isGridViewShowing);
              },
            );
          }),
    );
  }

  //------------Show vertical moving list---------------//
  Widget listView(List<Products> productList) {
    print('List Callback--${productList.length}');
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var data = productList;
          return ProductItemFullWidth(
            product: data[index],
          );
        });
  }

  //--------------------Handle load more----------------------//
  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (model?.tcount ?? 0) != productList.length) {
      // setState(() {
      if (model?.offset == offset && (offset + 10) < (model?.tcount ?? 0)) {
        offset += 10;
        catalogScreenBloc = context.read<CatalogScreenBloc>();
        print("checking${offset}");
        widget.catalogScreenPassData[fromHomePageKey]
            ? catalogScreenBloc?.add(CatalogScreenDataFetchFromHomeEvent(
                widget.catalogScreenPassData[urlKey], 10, offset))
            : catalogScreenBloc?.add(CatalogScreenDataFetchEvent(
                widget.catalogScreenPassData[customerIdKey], 10, offset));
        isFromPagination = true;
        catalogScreenBloc?.emit(CatalogScreenInitialState());
      }
      // });
    }
  }
}
