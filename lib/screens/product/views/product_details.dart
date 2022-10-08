// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

class ProductDetailsView extends StatefulWidget {
  String? description;

  ProductDetailsView(this.description, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: AppSizes.normalPadding),
      child: ExpansionTile(
        initiallyExpanded: (widget.description ?? '' ) != "" ? true : false,
          title: Text(
              _localizations?.translate(AppStringConstant.details) ?? '',
              style: Theme.of(context).textTheme.subtitle2),
          children: [
            Container(
                padding: const EdgeInsets.all(AppSizes.normalPadding),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(widget.description ?? '',
                        style: Theme.of(context).textTheme.bodyText1)
                    // ProductsWebView(widget.description ?? '')
                  ],
                )),
          ]),
    );
  }
}
