// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';

import '../bloc/product_screen_bloc.dart';
import '../bloc/product_screen_event.dart';
import '../bloc/product_screen_state.dart';

class QuantityView extends StatefulWidget {
  ValueChanged<int>? callBack;
  ProductScreenBloc? bloc;
  int? counter;

  QuantityView({this.callBack, this.bloc, this.counter});

  @override
  State<StatefulWidget> createState() {
    return _QuantityViewState();
  }
}

class _QuantityViewState extends State<QuantityView> {
  TextEditingController controller = TextEditingController();
  ProductScreenBloc? bloc;
  AppLocalizations? _localizations;

  @override
  void initState() {
    controller.text = "${widget.counter}";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool? isDarkMode = AppSharedPref().getThemeMode() ?? false;
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSizes.normalPadding),
      color: Theme.of(context).cardColor,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _localizations?.translate(AppStringConstant.quantity) ?? '',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          // SizedBox(
          //   height: AppSizes.normalPadding,
          // ),
          // Divider(),
          SizedBox(
            width: AppSizes.genericPadding,
          ),

       SizedBox(
              height: 36,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(2),
                      // color: Theme.of(context).colorScheme.onPrimary,
                      color: Color(isDarkMode? 0xff222222: 0xffeeeeee)
                    ),
                    width: 32,
                    child: InkWell(
                        onTap: () {
                          if (widget.counter! > 1) {
                            // setState(() {
                            widget.counter = (widget.counter ?? 1) - 1;
                            changeQty();
                            // });
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          // color: isDarkMode ? AppColors.black : AppColors.white,
                          color: Color(isDarkMode ? 0xffeeeeee : 0xff333333),
                        )),
                  ),
                  // Spacer(),
                  SizedBox(width: 6),
                  SizedBox(
                      width: 48,
                      child: TextField(
                        onChanged: (text) {
                          widget.counter = text.trim() != ''? int.parse(text): 0;
                          widget.bloc?.add(QuantityUpdateEvent(widget.counter));
                          widget.bloc?.emit(ProductScreenInitial());
                        },
                        enabled: true,
                        controller: controller,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(1.0),
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                                color: Color(isDarkMode? 0xff333333: 0xffdddddd)
                          ),
                        ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                          width: 1,
                          color: Color(isDarkMode? 0xff333333: 0xffdddddd)
                          ),
                          )
                        ),
                      )),
                  // Spacer(),
                  SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      // color: Theme.of(context).colorScheme.onPrimary,
                        color: Color(isDarkMode? 0xff222222: 0xffeeeeee)
                    ),
                    width: 32,
                    child: InkWell(
                        onTap: () {
                          // setState(() {
                          widget.counter = (widget.counter ?? 1) + 1;
                          changeQty();
                          // });
                        },
                        child: Icon(
                          Icons.add,
                          size: 20,
                          // color: isDarkMode ? AppColors.black : AppColors.white,
                          color: Color(isDarkMode ? 0xffeeeeee : 0xff333333),
                        )),
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }

  void changeQty() {
    print("qadsqds--${widget.counter}");
    widget.bloc?.add(QuantityUpdateEvent(widget.counter));
    widget.bloc?.emit(ProductScreenInitial());
    // controller.text = ("${widget.counter}" +
    //     ((widget.counter! > 1)
    //         ? " ${_localizations?.translate(AppStringConstant.units)}"
    //         : " ${_localizations?.translate(AppStringConstant.unit)}"));
    controller.text = "${widget.counter}";
  }
}
