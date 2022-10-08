import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_order_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/ShippingMethodModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/views/change_address_view.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/views/checkout_progress_line.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/views/new_address_container.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/shippingDetails/views/shipping_methods_view.dart';

import '../../../helper/alert_message.dart';
import '../../../models/AddressListModel.dart';

import 'bloc/checkout_screen_bloc.dart';
import 'bloc/checkout_screen_event.dart';
import 'bloc/checkout_screen_state.dart';

class CheckoutScreen extends StatefulWidget {
  String amtToBePaid = "";

  CheckoutScreen(this.amtToBePaid, {Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  bool showAddressPage = false;
  bool isHasDefaultShipping = false;
  AddressListModel? _addressListModel;
  ShippingMethodModel? _shippingMethodModel;
  CheckoutScreenBloc? _checkoutScreenBloc;
  int selectedShippingMethodIndex = 0;
  SplashScreenModel? model;

  @override
  void initState() {
    super.initState();
    _checkoutScreenBloc = context.read<CheckoutScreenBloc>();
    _checkoutScreenBloc?.add(const ShippingAddressFetchEvent());
    model = AppSharedPref().getSplashData();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonToolBar(
            _localizations?.translate(AppStringConstant.shipping) ?? '',
            context,
            isLeadingEnable: false,
            isElevated: false),
        body: SafeArea(
            child: BlocBuilder<CheckoutScreenBloc, CheckoutScreenState>(
          builder: (context, state) {
            if (state is CheckoutScreenInitial) {
              isLoading = true;
            } else if (state is ShippingAddressSuccess) {
              _addressListModel = state.model;
              if ((_addressListModel?.defaultShippingAddressId?.displayName ??
                      "")
                  .trim()
                  .isNotEmpty) {
                isHasDefaultShipping = true;
                _checkoutScreenBloc?.add(const ShippingMethodsFetchEvent());
              } else {
                isHasDefaultShipping = false;
                isLoading = false;
              }
            } else if (state is ShippingMethodSuccess) {
              isLoading = false;
              if(state.model?.success ?? false){
              _shippingMethodModel = state.model;
              }
              else{
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showError(state.model?.message ?? '', context);
                });
              }
            } else if (state is CheckoutError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.message ?? '', context);
              });
            } else if (state is ChangeShippingAddressState) {
              showAddressPage = true;
            }
            return isLoading ? Loader() : _buildUI();
          },
        )));
  }

  Widget _buildUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              checkoutProgressLine(true, context),
              (isHasDefaultShipping)
                  ? Column(
                      children: [
                        addressItemWithHeading(
                            context,
                            _localizations?.translate(
                                    AppStringConstant.shippingAddress) ??
                                '',
                            '${_addressListModel?.defaultShippingAddressId?.displayName}',
                            actions: actionContainer(context, () {
                              shippingAddressModelBottomSheet(context,
                                  (addressId) {
                                showAddressPage = false;
                                _checkoutScreenBloc?.emit(ShippingMethodSuccess(
                                    _shippingMethodModel ??
                                        ShippingMethodModel()));
                              }, _addressListModel);
                              _checkoutScreenBloc
                                  ?.add(const ChangeAddressEvent());
                            }, () {
                              Navigator.of(context)
                                  .pushNamed(addEditAddress)
                                  .then((value) {
                                if (value == true) {
                                  _checkoutScreenBloc
                                      ?.emit(CheckoutScreenInitial());
                                  _checkoutScreenBloc
                                      ?.add(const ShippingAddressFetchEvent());
                                }
                              });
                            },
                                titleLeft: _localizations?.translate(
                                        AppStringConstant.changeAddress) ??
                                    '',
                                titleRight: _localizations?.translate(
                                        AppStringConstant.newAddress) ??
                                    '')),
                        const SizedBox(
                          height: AppSizes.extraPadding,
                        ),
                        model?.allowShipping ?? false
                            ? addressItemWithHeading(
                                context,
                                _localizations?.translate(
                                        AppStringConstant.shippingMethod) ??
                                    '',
                                '',
                                addressList: ShippingMethodsView(
                                  shippingMethodList:
                                      _shippingMethodModel?.shippingMethods ??
                                          [],
                                  callBack: (selectedIndex) {
                                    selectedShippingMethodIndex = selectedIndex;
                                  },
                                ))
                            : Container()
                      ],
                    )
                  : addressItemWithHeading(
                      context,
                      _localizations
                              ?.translate(AppStringConstant.shippingMethod) ??
                          '',
                      '',
                      addressList: addNewAddress(
                          context,
                          _localizations?.translate(
                                  AppStringConstant.addNewAddress) ??
                              '', () {
                        Navigator.of(context)
                            .pushNamed(addEditAddress)
                            .then((value) {
                          if (value == true) {
                            _checkoutScreenBloc?.emit(CheckoutScreenInitial());
                            _checkoutScreenBloc
                                ?.add(const ShippingAddressFetchEvent());
                          }
                        });
                      }))
            ],
          ),
        )),
        commonOrderButton(context, _localizations, widget.amtToBePaid, () {
          if (_shippingMethodModel
                  ?.shippingMethods?[selectedShippingMethodIndex].id !=
              null) {
            if (AppSharedPref().getSplashData()?.addons?.odooGdpr == true &&
                AppSharedPref().getUserData()?.isEmailVerified != true) {
              AlertMessage.showError(
                  _localizations?.translate(
                          AppStringConstant.pleaseVerifyYourEmail) ??
                      "",
                  context);
            } else {
              Navigator.pushNamed(context, paymentReviewPage,
                  arguments: getCheckoutMap(
                      _shippingMethodModel
                              ?.shippingMethods?[selectedShippingMethodIndex]
                              .id ??
                          0,
                      _addressListModel?.defaultShippingAddressId?.addressId ??
                          0,
                      _addressListModel?.defaultShippingAddressId?.url ?? ""));
            }
          } else {
            AlertMessage.showError(
                _localizations?.translate(
                        AppStringConstant.pleaseSelectAddressOrShipping) ??
                    "",
                context);
          }
        })
      ],
    );
  }
}
