import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';
import 'package:flutter_project_structure/screens/signin_signup/view/my_bottom_sheet.dart';

import '../../../../helper/app_localizations.dart';
import '../../../../models/AddressListModel.dart';

class ShowAddressList extends StatefulWidget {
  Function(int) onTap;
  AddressListModel? addresses;

   ShowAddressList(this.onTap,this.addresses,{Key? key}) : super(key: key);

  @override
  _ShowAddressListState createState() => _ShowAddressListState();
}

class _ShowAddressListState extends State<ShowAddressList> {
   AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: commonToolBar(_localizations?.translate(AppStringConstant.shipping) ?? "", context, isLeadingEnable: true),
      body: ListView.builder(
          itemCount: widget.addresses?.addresses?.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item = widget.addresses?.addresses?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.imageRadius),
              child: InkWell(
                  onTap: () {

                    widget.addresses?.defaultShippingAddressId = item;
                    widget.onTap(item?.addressId ?? 0);

                    Navigator.pop(context);
                  },
                  child: addressItemCard(item?.displayName ?? "", context, isSelected: item?.addressId == widget.addresses?.defaultShippingAddressId?.addressId)),
            );
          },
      ),
    );}
}



