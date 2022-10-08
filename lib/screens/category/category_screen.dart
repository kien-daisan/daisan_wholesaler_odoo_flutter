import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_bloc.dart';
import 'package:flutter_project_structure/screens/category/widgets/category_products.dart';
import 'package:flutter_project_structure/screens/category/widgets/category_tile.dart';

class CategoryScreen extends StatefulWidget {


  CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  AppLocalizations? _localizations;
  CategoryScreenBloc? categoryScreenBloc;
  int _selectedIndex = 0;
  HomePageData? homePageData;
  bool? isSubCategoryLoading;
  bool isLoading = true;
  List<Categories>? categories;
  CategoryScreenModel? categoryScreenModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    categoryScreenBloc = context.read<CategoryScreenBloc>();
    categoryScreenBloc?.add(CategoryHomeFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          "${_localizations?.translate(AppStringConstant.categories)}", context,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, searchPage);
                },
                icon: const Icon(Icons.search,
                    )),
            IconButton(
                onPressed: () {
                  notificationBottomModelSheet(context);
                },
                icon: const Icon(Icons.notifications,
                    ))
          ]),
      body: BlocBuilder<CategoryScreenBloc, CategoryScreenState>(
          builder: (context, state) {
        if (state is CategoryScreenInitial) {
          isSubCategoryLoading = true;
        } else if (state is CategoryHomeApiSuccess) {
          categories = state.homePageData?.categories;
          categoryScreenBloc?.add(CategoryScreenDataFetchEvent(
              categories?[0].categoryId ?? 0, 10, 0));
          isLoading = false;
        } else if (state is CategoryScreenSuccess) {
          categoryScreenModel = state.category;
          isSubCategoryLoading = false;
          AnalyticsEventsFirebase().viewCategory(categoryScreenModel?.products?.map((e) => AnalyticsEventItem(itemId: e.productId.toString(),itemName: e.name,)).toList());

        } else if (state is CategoryScreenError) {
          isSubCategoryLoading = true;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? '', context);
          });
        }
        return (isLoading == true)
            ? Loader()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [categoryListView(), subcategoryListView()],
              );
      }),
    );
  }

  //========For Left (main) categories==========//
  Widget categoryListView() {
    return SizedBox(
      width: AppSizes.width / 3.5,
      height: AppSizes.height,
      // color: Theme.of(context).dividerColor,
      child: ListView.builder(
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: categories?.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  categoryScreenModel?.products = null;
                  categoryScreenBloc?.add(CategoryScreenDataFetchEvent(
                      categories?[index].categoryId ?? 0, 25, 0));
                  categoryScreenBloc?.emit(CategoryScreenInitial());
                  setState(() {
                    _selectedIndex = index;
                    // if(categories?[index].children?.length == 0){
                    // }
                  });
                },
                child: Container(
                    color: _selectedIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : AppColors.lightGray,
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.extraPadding, horizontal: AppSizes.normalPadding),
                    // height: AppSizes.height * 0.07,
                    child: Center(
                      child: Text(
                        (categories?[index].name ?? "") ,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    )));
          }),
    );
  }

  //======For Right (sub) categories========//
  Widget subcategoryListView() {
    var width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 3.5;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child:
                (categories?[_selectedIndex].children ?? []).isNotEmpty
                    ? Column(
                        children: [
                          CategoryTile(
                            subCategories:
                                categories?[_selectedIndex].children,
                          ),
                          const SizedBox(height: AppSizes.sidePadding),
                          categoryProducts()
                        ],
                      )
                    : categoryProducts(),
          ),
        ],
      ),
    );
  }

  //=========Showing products for selected category=======//
  Widget categoryProducts() {
    return buildCategoryProducts(
        categoryScreenModel?.products ?? [],
        _localizations,
        context,
        isSubCategoryLoading,
        categories?[_selectedIndex].categoryId,
        categories?[_selectedIndex].name ?? "");
  }
}
