// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/extension.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';

import '../bloc/product_screen_state.dart';

class ProductVariants extends StatefulWidget {
  ProductScreenModel productPageData;
  ProductScreenBloc? productPageBloc;

  ProductVariants(this.productPageData, this.productPageBloc);

  @override
  State<StatefulWidget> createState() => _ProductVariantsState();
}

class _ProductVariantsState extends State<ProductVariants> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isDefaultCombination();
    List<Attribute> attributeList = widget.productPageData.attributes!;
    return Container(
      color: Theme.of(context).cardColor,
      width: AppSizes.width,
      padding: const EdgeInsets.all(AppSizes.imageRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...attributeList.map((attribute) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSizes.linePadding, bottom: AppSizes.linePadding),
                  child: Text(
                    attribute.name ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                AppConstant.radioType == attribute.type
                    ? _buildRadio(
                        attribute.attributeId ?? 0, attribute.values ?? [])
                    : AppConstant.colorType == attribute.type
                        ? _buildColor(
                            attribute.attributeId ?? 0, attribute.values ?? [])
                        : _createDropdown(attribute.values ?? [])
              ],
            );
          })
        ],
      ),
    );
  }

  //===========Build UI according to attribute type===========//
  Widget _buildRadio(int attributeId, List<Values> data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          data.length,
          (index) {
            return RadioListTile<String>(
              dense: true,
              selected: data[index].isSelected ?? false,
              title: Text(
                data[index].name ?? "",
              ),
              value: data[index].name ?? "",
              groupValue:
                  (data[index].isSelected ?? false) ? data[index].name : "",
              onChanged: (value) {
                for (Values d in data) {
                  d.isSelected = false;
                }
                data[index].isSelected = true;
                updateSelection();
              },
            );
          },
        ),
      );

  Widget _createDropdown(List<Values> data) {
    Values selected = Values();
    for (Values v in data) {
      if (v.isSelected ?? false) {
        selected = v;
      }
    }
    return DropdownButtonFormField<Values>(
      value: selected,
      decoration: const InputDecoration(
        isDense: true,
        focusedBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
      ),
      items: data
          .map((Values optionData) => DropdownMenuItem(
                child: Text(optionData.name.toString()),
                value: optionData,
              ))
          .toList(),
      onChanged: (value) {
        for (Values d in data) {
          d.isSelected = false;
        }
        value?.isSelected = true;
        updateSelection();
      },
      validator: (value) {},
    );
  }

  Widget _buildColor(int attributeId, List<Values> data) => Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(data.length, (index) {
          String color = data[index].htmlCode ?? "FFFFFF";
          if (color.isEmpty) {
            color = "FFFFFF";
          }
          return InkWell(
            onTap: () {
              for (Values d in data) {
                d.isSelected = false;
              }
              data[index].isSelected = true;
              updateSelection();
            },
            child: _colorContainer(data[index].isSelected ?? false,
                color: HexColor.fromHex(color)),
          );
        }),
      );

  Widget _colorContainer(bool isSelected, {String? size, Color? color}) {
    return Card(
      elevation: 4,
      child: Container(
        height: AppSizes.widgetBorderRadius,
        width: (AppSizes.widgetBorderRadius + AppSizes.normalPadding),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).dividerColor),
            color: (color != null) ? color : AppColors.background),
        child: (size != null)
            ? Center(
                child: Text(
                size,
                style: Theme.of(context).textTheme.headline4,
              ))
            : null,
      ),
    );
  }

  //=========Show default selected combinations===========//
  void isDefaultCombination() {
    if (widget.productPageData.variants != null) {
      for (ProductScreenModel model in widget.productPageData.variants!) {
        if (model.productId == widget.productPageData.productId) {
          for (Combinations c in model.combinations ?? []) {
            for (Attribute a in widget.productPageData.attributes ?? []) {
              if (a.attributeId == c.attributeId) {
                for (Values v in a.values ?? []) {
                  if (c.valueId == v.valueId) {
                    v.isSelected = true;
                  } else {
                    v.isSelected = false;
                  }
                }
              }
            }
          }
          break;
        }
      }
    }
  }

  void updateSelection() {
    widget.productPageBloc?.emit(ProductScreenInitial());
    List<Combinations> combination = [];
    //--------Get Current Selected Variant----------//
    for (Attribute a in widget.productPageData.attributes ?? []) {
      for (Values v in a.values ?? []) {
        if (v.isSelected ?? false) {
          combination.add(
              Combinations(valueId: v.valueId, attributeId: a.attributeId));
        }
      }
    }
    //-----------------Completed fetch variants--------------//

    //===========Set Updated Product according to the selection============//
    for (ProductScreenModel v in widget.productPageData.variants ?? []) {
      if (_listsAreEqual(v.combinations ?? [], combination)) {
        widget.productPageData.productId = v.productId;
        widget.productPageData.images = v.images;
        widget.productPageData.arIos = v.arIos;
        widget.productPageData.arAndroid = v.arAndroid;
        widget.productPageData.absoluteUrl = v.absoluteUrl;
        widget.productPageData.priceUnit = v.priceUnit;
        widget.productPageData.priceReduce = v.priceReduce;
        widget.productPageData.addedToWishlist = v.addedToWishlist;
        widget.productPageData.addToCart = v.addToCart;
        widget.productPageData.stockDisplayMsg = v.stockDisplayMsg;

        widget.productPageBloc
            ?.emit(ProductScreenSuccess(widget.productPageData));
        print("*******true---${widget.productPageData.productId}");
        break;
      }
    }
  }

  //==========Check if selected lists or combination list are equal===========//
  bool _listsAreEqual(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;
      return two[i] == element;
    });
  }
}
