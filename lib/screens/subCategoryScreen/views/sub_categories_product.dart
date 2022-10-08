import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategroy_screen_bloc.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategory_screen_state.dart';
import '../../../config/theme.dart';
import '../../../constants/app_constants.dart';
import '../../home/views/home_collection_view.dart';
import '../../home/views/product_list_widgets/product_list_widgets.dart';

Widget subCategoryProduct(BuildContext context, AppLocalizations? _localizations, int cid,String categoryName){
  CategoryScreenModel? model;
  bool isLoading = false;
  return BlocBuilder<SubcategoryBloc, SubCategoryState>(
      builder:(context, state){
        if(state is SubCategoryInitialState){
          isLoading = true;
        }else if(state is SubCategorySuccessState){
          isLoading = false;
          model = state.categoryScreenModel;
        }else if(state is SubCategoryErrorState){
          isLoading = true;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? '', context);
          });
        }
        return buildUI(context, _localizations!,isLoading, model, cid,categoryName);
      }
      );

}

  Widget buildUI(BuildContext context, AppLocalizations _localizations, bool isLoading, CategoryScreenModel? model, int cid,String categoryName){
    return isLoading ? Loader()
        :Visibility(
      visible: model?.products != null,
          child: Container(
      padding:  const EdgeInsets.symmetric(vertical: AppSizes.sidePadding, horizontal: AppSizes.imageRadius),
      color: Theme.of(context).cardColor,
      child: (model?.products?.isNotEmpty ??  false) ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(AppSizes.imageRadius/2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.imageRadius/2),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Text(_localizations.translate(AppStringConstant.products),
                      style: Theme.of(context).textTheme.headline5),
                ),
                viewAllButton(context, () {
                  Navigator.pushNamed(context, catalogPage, arguments: getCatalogMap( "", false,categoryName,customerId: cid,));
                }),
              ],
            ),
            const SizedBox(
              height: AppSizes.imageRadius,
            ),
            buildHorizontalProduct(model?.products ?? []
                , _localizations),
          ],
      ) : Center(child:  Text(_localizations.translate(AppStringConstant.noProduct)),),
    ),
        );
}