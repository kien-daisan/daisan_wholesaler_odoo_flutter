import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/screens/addressBook/bloc/addressbook_screen_bloc.dart';
import 'package:flutter_project_structure/screens/addressBook/bloc/addressbook_screen_event.dart';
import 'package:flutter_project_structure/screens/addressBook/bloc/addressbook_screen_state.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';

class AddressBook extends StatelessWidget {
  AppLocalizations? _localizations;
  bool isLoading = false;
  AddressListModel? _addressListModel;
  AddressBookScreenBloc? _addressBookScreenBloc;
  String? defaultBillingUrl;
  String? defaultBillingAddress;

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    _addressBookScreenBloc = context.read<AddressBookScreenBloc>();
    _addressBookScreenBloc?.add(const AddressBookDataFetchEvent());
    return Scaffold(
      appBar: commonToolBar(
          _localizations?.translate(AppStringConstant.addressBook) ?? "",
          context),
      body: BlocBuilder<AddressBookScreenBloc, AddressBookState>(
        builder: (context, state) {
          if (state is AddressBookInitial) {
            isLoading = true;
          } else if (state is AddressBookSuccess) {
            isLoading = false;
            _addressListModel = state.model;
            getDefaultBillingAddress();
          } else if (state is AddressBookError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(state.message ?? '', context);
            });
          } else if (state is DeleteAddressSuccess) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (state.model.success ?? false) {
                AlertMessage.showSuccess(state.model.message ?? '', context);
              } else {
                AlertMessage.showError(state.model.message ?? '', context);
              }
            });

            _addressBookScreenBloc?.add(const AddressBookDataFetchEvent());
            _addressBookScreenBloc?.emit(AddressBookInitial());
          }
          return buildUI(context);
        },
      ),
    );
  }

  Widget buildUI(BuildContext context) {
    // print("wqqwdsd--${getDefaultBillingAddress()?.displayName}");
    return Stack(
      children: [
        _addressListModel != null &&
                (_addressListModel?.addresses ?? []).isNotEmpty
            ? ((_addressListModel?.defaultShippingAddressId?.displayName ?? "")
            .trim()
            .isNotEmpty)
            ? SingleChildScrollView(
          child: Column(
            children: [
              addAddressContainer(context),
              (defaultBillingAddress != '') ?

              addressItemWithHeading(
                            context,
                            _localizations?.translate(AppStringConstant
                                    .defaultBillingAddress) ??
                                "",
                            defaultBillingAddress ?? '', callback: () {
                          Navigator.of(context)
                              .pushNamed(addEditAddress,
                                  arguments: defaultBillingUrl ?? '')
                              .then((value) {
                            if (value == true) {
                              _addressBookScreenBloc
                                  ?.emit(AddressBookInitial());
                              _addressBookScreenBloc
                                  ?.add(const AddressBookDataFetchEvent());
                            }
                          });
                        }) : Container(),
                        addressItemWithHeading(
                            context,
                            _localizations?.translate(AppStringConstant
                                    .defaultShippingAddress) ??
                                "",
                            _addressListModel
                                    ?.defaultShippingAddressId?.displayName ??
                                "", callback: () {
                          Navigator.of(context)
                              .pushNamed(addEditAddress,
                                  arguments: _addressListModel
                                          ?.defaultShippingAddressId?.url ??
                                      "")
                              .then((value) {
                            if (value == true) {
                              _addressBookScreenBloc
                                  ?.emit(AddressBookInitial());
                              _addressBookScreenBloc
                                  ?.add(const AddressBookDataFetchEvent());
                            }
                          });
                        }),
                        ((_addressListModel?.addresses != null) &&
                                (_addressListModel!.addresses!.isNotEmpty) &&(_addressListModel!.addresses!.length > 1))
                            ? addressItemWithHeading(
                                context,
                                _localizations?.translate(
                                        AppStringConstant.otherAddresses) ??
                                    "",
                                "",
                                addressList: addressList()
                          )
                            : const SizedBox(
                                height: 0,
                                width: 0,
                              ),
                      ],
                    ),
                  )
                : getEmptyAddressView(context)
            : getEmptyAddressView(context),
        Visibility(
          visible: isLoading,
          child: Loader(),
        ),
      ],
    );
  }

  Widget getEmptyAddressView(BuildContext context) {
    if (isLoading) {
      return const SizedBox();
    }
    return lottieAnimation(
        context,
        "lib/assets/lottie/empty_address.json",
        _localizations?.translate(AppStringConstant.noAddress) ?? '',
        _localizations?.translate(AppStringConstant.noAddressMessage) ?? "",
        _localizations?.translate(AppStringConstant.addNewAddress) ?? '', () {
      Navigator.of(context).pushNamed(addEditAddress, arguments: ((_addressListModel?.defaultShippingAddressId?.displayName)?.trim() == '') ? _addressListModel?.defaultShippingAddressId?.url : null ).then((value) {
        if (value == true) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            _addressBookScreenBloc?.emit(AddressBookInitial());
            _addressBookScreenBloc?.add(const AddressBookDataFetchEvent());
          });
        }
      });
    });
  }

  //==============Add Address Container==========//
  Widget addAddressContainer(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(addEditAddress).then((value) {
          if (value == true) {
            _addressBookScreenBloc?.emit(AddressBookInitial());
            _addressBookScreenBloc?.add(const AddressBookDataFetchEvent());
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
        color: Theme.of(context).colorScheme.onPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.secondaryContainer),
            const SizedBox(
              width: AppSizes.imageRadius,
            ),
            Text(
              _localizations
                      ?.translate(AppStringConstant.addNewAddress)
                      .toUpperCase() ??
                  "",
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer),
            )
          ],
        ),
      ),
    );
  }

  //=========Address List===========//
  Widget addressList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: (_addressListModel?.addresses?.length ?? 1) ,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Addresses? data = _addressListModel?.addresses?[index];
          return (_addressListModel?.addresses?[index].addressId != _addressListModel?.customerId)
              ? addressItemCard(data?.displayName ?? "", context,
              actions: actionContainer(context, () {
                Navigator.of(context)
                    .pushNamed(addEditAddress, arguments: data?.url)
                    .then((value) {
                  if (value == true) {
                    _addressBookScreenBloc?.emit(AddressBookInitial());
                    _addressBookScreenBloc
                        ?.add(const AddressBookDataFetchEvent());
                  }
                });
              }, () {
                _addressBookScreenBloc?.add(DeleteAddressEvent(
                    _addressListModel?.addresses?[index].addressId.toString() ??
                        ''));
              },
                  titleLeft: _localizations?.translate(AppStringConstant.edit),
                  titleRight:
                      _localizations?.translate(AppStringConstant.delete),
                  iconRight: Icons.delete))
          : Container();
        });
  }

  //=========Filter Default Billing Address from list===========//
  Addresses? getDefaultBillingAddress() {
    for (Addresses a in _addressListModel?.addresses ?? []) {
      if (a.addressId == _addressListModel?.customerId) {
        defaultBillingUrl = a.url;
        defaultBillingAddress = a.displayName;
        // _addressListModel?.addresses
        //     ?.remove(a); //------To remove default address from address List
        return a;
      }
    }

    return null;
  }
}
