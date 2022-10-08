import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/AddressDetailModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/screens/addEditAddress/bloc/add_edit_address_screen_event.dart';
import 'package:flutter_project_structure/screens/addEditAddress/bloc/add_edit_address_state.dart';
import 'package:flutter_project_structure/screens/addEditAddress/views/country_state_dropdown.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as locationReq;

import '../../helper/alert_message.dart';
import 'bloc/add_edit_address_screen_bloc.dart';

class AddEditAddress extends StatefulWidget {
  String? addressEndpoint;

  AddEditAddress({Key? key, this.addressEndpoint}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddEditAddressState();
  }
}

class _AddEditAddressState extends State<AddEditAddress> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  bool initialLoading = true;
  AddEditAddressScreenBloc? addressScreenBloc;
  CountryListModel? _countryListModel;
  AddressDetailModel? _addressDetailModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  int? selectedCountryId;
  int? selectedStateId;
  bool hasState = false;
  bool isFromMap = false;
  late GlobalKey<FormState> _formKey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    addressScreenBloc = context.read<AddEditAddressScreenBloc>();
    addressScreenBloc?.add(const AddEditAddressDataFetchEvent());
    _formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonToolBar(
          (widget.addressEndpoint != null)
              ? _localizations?.translate(AppStringConstant.editAddress) ?? ""
              : _localizations?.translate(AppStringConstant.addNewAddress) ??
                  "",
          context),
      body: BlocBuilder<AddEditAddressScreenBloc, AddEditAddressState>(
        builder: (context, state) {
          if (state is AddEditAddressInitial) {
            isLoading = true;
          } else if (state is AddEditAddressCountrySuccess) {
            if (widget.addressEndpoint != null) {
              addressScreenBloc
                  ?.add(AddressDetailFetchEvent(widget.addressEndpoint ?? ""));
            } else {
              isLoading = false;
              initialLoading = false;
            }
            _countryListModel = state.model;
          } else if (state is AddressDetailFetchSuccess) {
            isLoading = false;
            initialLoading = false;
            _addressDetailModel = state.model;
            setAddressDetails();
          } else if (state is AddEditAddressError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(state.message ?? '', context);
            });
          } else if (state is AddAddressSuccess) {
            isLoading = false;
            if (state.model.success == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.model.message ?? '', context);
                Navigator.of(context).pop(true);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.model.message ?? '', context);
              });
            }
          } else if (state is UpdateAddressSuccess) {
            isLoading = false;
            if (state.model.success == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.model.message ?? '', context);
                Navigator.of(context).pop(true);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.model.message ?? '', context);
              });
            }
          }
          return buildUI();
        },
      ),
    );
  }

  void setAddressDetails() {
    if(!isFromMap) {
      nameController.text = _addressDetailModel?.name ?? "";
      telephoneController.text = _addressDetailModel?.phone ?? "";
      streetController.text = _addressDetailModel?.street ?? "";
      cityController.text = _addressDetailModel?.city ?? "";
      zipController.text = _addressDetailModel?.zip ?? "";
      selectedCountryId = (_addressDetailModel?.countryId is int)
          ? _addressDetailModel?.countryId
          : 0;
      selectedStateId =
      (_addressDetailModel?.stateId is int) ? _addressDetailModel?.stateId : 0;
    }
  }

  Widget buildUI() {
    return initialLoading
        ? Loader()
        : Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(AppSizes.imageRadius),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headingText(_localizations?.translate(
                                  AppStringConstant.contactInformation) ??
                              ""),
                          InkWell(
                            onTap: () async {
                              var status = await locationReq.Location.instance
                                  .hasPermission();
                              if (status ==
                                      locationReq.PermissionStatus.granted ||
                                  status ==
                                      locationReq
                                          .PermissionStatus.grantedLimited) {
                                Navigator.pushNamed(context, location)
                                    .then((value) {
                                  if (value is Map) {
                                    print('values ----- $value');
                                    filterSelectedCountryState(
                                        value["country"], value["state"]);
                                    cityController.text = value['city'];
                                    // zipController.text = value['zip'];
                                    streetController.text = value['street1'];
                                    if((value["street3"] != null) && value["street3"] != ''){
                                      streetController.text += " " + value["street3"];
                                    }
                                    isFromMap = true;
                                  }
                                });
                              } else {
                                DialogHelper.locationPermissionDialog(
                                    AppStringConstant
                                        .requiredLocationPermission,
                                    context,
                                    _localizations, onConfirm: () async {
                                  var status = await locationReq
                                      .Location.instance
                                      .requestPermission();
                                  if (status ==
                                      locationReq
                                          .PermissionStatus.deniedForever) {
                                    DialogHelper.locationPermissionDialog(
                                        AppStringConstant
                                            .provideLocationPermission,
                                        context,
                                        _localizations, onConfirm: () async {
                                      openAppSettings();
                                    });
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100))),
                              child: Icon(
                                Icons.my_location,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            ),
                          )
                        ],
                      ),
                      createTextField(
                          _localizations
                                  ?.translate(AppStringConstant.yourName) ??
                              "",
                          nameController),
                      createTextField(
                          _localizations
                                  ?.translate(AppStringConstant.telephone) ??
                              "",
                          telephoneController,
                          inputType: TextInputType.phone),
                      headingText(_localizations
                              ?.translate(AppStringConstant.address) ??
                          ""),
                      createTextField(
                          _localizations?.translate(
                                  AppStringConstant.streetAddress) ??
                              "",
                          streetController),
                      createTextField(
                          _localizations?.translate(AppStringConstant.city) ??
                              "",
                          cityController),
                      // createTextField(
                      //     _localizations
                      //             ?.translate(AppStringConstant.zipCode) ??
                      //         "",
                      //     zipController),
                      const SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      CountryDropdown(
                          _countryListModel?.countries ?? [],
                          selectedCountryId,
                          selectedStateId,
                          countryStateCallback),
                      const SizedBox(
                        height: AppSizes.sidePadding,
                      ),
                      commonButton(
                          context,
                          handleSaveClick,
                          _localizations?.translate(
                                  AppStringConstant.saveAddress) ??
                              "",
                          backgroundColor: AppColors.black,
                          textColor: AppColors.white),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading) Loader()
          ],
        );
  }

  void handleSaveClick() {
    if (_formKey.currentState?.validate() == true) {
      addressScreenBloc?.emit(AddEditAddressInitial());
      if (widget.addressEndpoint != null) {
        addressScreenBloc?.add(UpdateAddressEvent(
            widget.addressEndpoint ?? "",
            nameController.text,
            telephoneController.text,
            streetController.text,
            cityController.text,
            zipController.text,
            selectedCountryId.toString(),
            selectedStateId.toString()));
      } else {
        addressScreenBloc?.add(AddAddressEvent(
            nameController.text,
            telephoneController.text,
            streetController.text,
            cityController.text,
            zipController.text,
            selectedCountryId.toString(),
            selectedStateId.toString()));
      }
    }
  }

  void countryStateCallback(int? countryId, int? stateId, bool hasStates) {
    selectedStateId = stateId;
    selectedCountryId = countryId;
    hasState = hasState;
  }

  Widget headingText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.sidePadding,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: AppSizes.linePadding,
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget createTextField(String hintText, TextEditingController controller,
      {inputType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.sidePadding),
      child: CommonTextField(
        hintText: hintText,
        isRequired: true,
        isDense: false,
        controller: controller,
        isPassword: false,
        inputType: inputType,
      ),
    );
  }

  //======This will use to filter data from current location========//
  void filterSelectedCountryState(String? country, String? state) {
    print("dadsa--$country----$state");
    if (_countryListModel?.countries != null) {
      for (Countries cou in _countryListModel?.countries ?? []) {
        if (cou.name?.toLowerCase() == country?.toLowerCase()) {
          print("dadsa--Country Found----");
          selectedCountryId = cou.id;
          if ((cou.states ?? []).isNotEmpty) {
            for (States s in cou.states ?? []) {
              if (s.name?.toLowerCase() == state?.toLowerCase()) {
                print("dadsa--State Found----");
                setState(() {
                  selectedStateId = s.id;
                });
                break;
              }
            }
            if (selectedStateId == null) {
              setState(() {});
            }
          }
          break;
        }
      }
    }
  }
}
