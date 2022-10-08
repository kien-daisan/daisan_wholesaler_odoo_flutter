import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategroy_screen_bloc.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/views/categories_list.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/views/sub_categories_product.dart';
import 'package:provider/src/provider.dart';
import '../../constants/app_constants.dart';
import '../../helper/app_localizations.dart';
import 'bloc/subcategory_screen_event.dart';

class SubCategoryScreen extends StatefulWidget {
  Map<String, dynamic> arguments;

  SubCategoryScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubCategoryScreenState();
  }
}

class SubCategoryScreenState extends State<SubCategoryScreen> {
  AppLocalizations? _localizations;
  SubcategoryBloc? subcategoryBloc;

  @override
  void initState() {
    print(widget.arguments);
    subcategoryBloc = context.read<SubcategoryBloc>();
    subcategoryBloc?.add(SubCategoryScreenDatFetchEvent(
        widget.arguments[customerIdKey] ?? 0, 10, 0));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: commonAppBar(widget.arguments[categoryNameKey].toString(), context,actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, searchPage);
        }, icon: const Icon(Icons.search))
      ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            subCategoryProduct(
                context, _localizations, widget.arguments[customerIdKey] ?? 0,widget.arguments[categoryNameKey]),
            const SizedBox(
              height: AppSizes.widgetSidePadding,
            ),
            categoriesListCard(
                context, widget.arguments[subCategoryListKey], _localizations)
          ],
        ),
      ),
    );
  }
}
