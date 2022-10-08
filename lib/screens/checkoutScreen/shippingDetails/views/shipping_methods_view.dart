import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/ShippingMethodModel.dart';

class ShippingMethodsView extends StatefulWidget {
  List<ShippingMethods>? shippingMethodList;
  ValueChanged<int>? callBack;
  List<Acquirers>? paymentMethods;
  VoidCallback? paymentcallback;

  ShippingMethodsView(
      {Key? key,
      this.shippingMethodList,
      this.callBack,
      this.paymentMethods,
      this.paymentcallback})
      : super(key: key);

  @override
  _ShippingMethodsState createState() => _ShippingMethodsState();
}

class _ShippingMethodsState extends State<ShippingMethodsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        (widget.shippingMethodList ?? []).isEmpty
            ? widget.paymentMethods?.length ?? 0
            : widget.shippingMethodList?.length ?? 0,
        (index) {
          var item;
          if ((widget.shippingMethodList ?? []).isNotEmpty) {
            item = widget.shippingMethodList?[index];
          } else {
            item = widget.paymentMethods?[index];
          }
          return Padding(
            padding: const EdgeInsets.only(top: AppSizes.imageRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<String>(
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  selected: selectedIndex == index,
                  title: Text(
                    item?.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  subtitle: (widget.shippingMethodList ?? []).isNotEmpty
                      ? Text(item?.price ?? "")
                      : Text(item?.code),
                  value: (item?.id ?? "").toString(),
                  groupValue:
                      (selectedIndex == index) ? (item?.id.toString()) : "",
                  onChanged: (value) {
                    setState(() {
                      // if((widget.shippingMethodList ?? []).isEmpty){
                      // }
                      print("dgydgygf");
                      if (widget.paymentcallback != null) {
                        widget.paymentcallback!();
                      }

                      selectedIndex = index;
                      if (widget.callBack != null) {
                        widget.callBack!(selectedIndex);
                      }
                    });
                  },
                ),
                const Divider(
                  thickness: 0.5,
                  height: 0.5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
