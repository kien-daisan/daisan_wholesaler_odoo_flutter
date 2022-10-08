import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_banner_view.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_events.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_project_structure/screens/dashboard/views/collapse_appbar.dart';
import 'package:flutter_project_structure/screens/dashboard/views/contact_info.dart';
import 'package:flutter_project_structure/screens/orders/orders_screen.dart';
import '../orders/bloc/order_screen_bloc.dart';
import '../orders/bloc/order_screen_repository.dart';

import '../../models/UserDataModel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  bool defaultShipping = false;
  bool showAddressPage = false;
  TabController? _tabController;
  AppLocalizations? _localizations;
  DashboardBloc? _dashboardBloc;
  String? name, email;
  OrderModel? orderList;
  AddressListModel? addressList;
  String? billingAddressUrl;
  AccountInfoModel? imageModel;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  Widget orderScreen = BlocProvider(
      create: (context) =>
          OrderScreenBloc(repository: OrderScreenRepositoryImp()),
      child: OrderScreen(true));

  @override
  void initState() {
    _dashboardBloc = context.read<DashboardBloc>();
    _dashboardBloc?.add(const DashboardDataFetchEvent(0, 10));
    UserDataModel? userData = AppSharedPref().getUserData();
    name = userData?.name ?? "";
    email = userData?.email;
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: commonToolBar(
            _localizations?.translate(AppStringConstant.dashboard) ?? "",
            context,
            isElevated: false),
        body: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, currentState) {
          if (currentState is DashboardLoadingState) {
            isLoading = true;
          } else if (currentState is DashboardSuccessState) {
            isLoading = false;
            orderList = currentState.order;
            addressList = currentState.address;
            if ((addressList?.defaultShippingAddressId?.displayName ?? "")
                .trim()
                .isNotEmpty) {
              defaultShipping = true;
            }
          } else if (currentState is DashboardErrorState) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message, context);
            });
          } else if (currentState is DashboardOrderSuccessState) {
            isLoading = false;
            orderList = currentState.order;
          } else if (currentState is DashboardAddressSuccessState) {
            isLoading = false;
            addressList = currentState.address;
            if ((addressList?.defaultShippingAddressId?.displayName ?? "")
                .trim()
                .isNotEmpty) {
              defaultShipping = true;
            }
          } else if (currentState is ChangeShippingAddressState) {
            showAddressPage = true;
          } else if (currentState is SaveShippingAddressState) {
            if (currentState.data.success ?? false) {
              showAddressPage = false;
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.data.message ?? '', context);
              });
            }
          } else if (currentState is AddImageState) {
            isLoading = false;
            imageModel = currentState.model;
            if (currentState.model?.success ?? false) {
              var data = AppSharedPref().getUserData();
              data?.profileImage = imageModel?.customerProfileImage;
              data?.bannerImage = imageModel?.customerBannerImage;
              AppSharedPref().setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.model?.message ?? '', context);
              });
            }
          } else if (currentState is DeleteImageState) {
            isLoading = false;
            if (currentState.model?.success ?? false) {
              var data = AppSharedPref().getUserData();
              data?.profileImage = '';
              AppSharedPref().setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.model?.message ?? '', context);
              });
            }
          } else if (currentState is DeleteBannerImageState) {
            isLoading = false;
            if (currentState.model?.success ?? false) {
              var data = AppSharedPref().getUserData();
              data?.bannerImage = '';
              AppSharedPref().setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.model?.message ?? '', context);
              });
            }
          }
          return _buildUI();
        }),
      ),
    );
  }

  Widget _buildUI() {
    return collapseAppBar(
      context,
      CommonBannerView((image, type) {
        _dashboardBloc?.add(AddImageEvent(image, type));
      }, (type) {
        if (type == AppConstant.bannerImage) {
          _dashboardBloc?.add(const DeleteBannerImageEvent());
        } else {
          _dashboardBloc?.add(const DeleteImageEvent());
        }
      }),
      Stack(children: [
        TabBarView(
            // physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              getTabScreens(
                contactInfo(
                    context,
                    _localizations,
                    _localizations
                            ?.translate(AppStringConstant.contactInformation) ??
                        '',
                    name ?? '',
                    email ?? ''),
              ),
              Column(
                children: [
                  Expanded(child: orderScreen),
                  Container(
                      color: Theme.of(context).cardColor,
                      // margin: const EdgeInsets.only(top: AppSizes.imageRadius),
                      padding: const EdgeInsets.all(AppSizes.imageRadius),
                      child: commonButton(context, () {
                        Navigator.of(context)
                            .pushNamed(orders, arguments: false);
                      },
                          _localizations
                                  ?.translate(AppStringConstant.viewAll) ??
                              '',
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          textColor:
                              Theme.of(context).colorScheme.secondaryContainer))
                ],
              ),
              // orderScreen,
              getTabScreens((addressList != null && (!isLoading))
                  ? addressInfo(_localizations
                          ?.translate(AppStringConstant.addressBook) ??
                      '')
                  : Container())
            ]),
        Visibility(visible: isLoading, child: Loader())
      ]),
      tabBar: TabBar(
        isScrollable: true,
        indicatorColor: AppColors.black,
        controller: _tabController,
        labelPadding: const EdgeInsets.all(0.0),
        tabs: [
          _getTab(_localizations?.translate(AppStringConstant.account) ?? ''),
          _getTab(
              _localizations?.translate(AppStringConstant.recentOrder) ?? ''),
          _getTab(_localizations?.translate(AppStringConstant.address) ?? '')
        ],
      ),
    );
  }

  Widget getTabScreens(Widget child) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: child,
    );
  }

  Widget addressInfo(String title) {
    return (defaultShipping)
        ? SizedBox(
            height: AppSizes.height - (AppBar().preferredSize.height * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addressItemWithHeading(
                    context,
                    _localizations?.translate(
                            AppStringConstant.defaultBillingAddress) ??
                        "",
                    getDefaultBillingAddress()?.displayName ?? "",
                    callback: () {
                  Navigator.of(context)
                      .pushNamed(addEditAddress, arguments: billingAddressUrl)
                      .then((value) {
                    if (value == true) {
                      _dashboardBloc?.add(DashboardAddressFetchEvent());
                    }
                  });
                }),
                addressItemWithHeading(
                    context,
                    _localizations?.translate(
                            AppStringConstant.defaultShippingAddress) ??
                        "",
                    addressList?.defaultShippingAddressId?.displayName ?? "",
                    actions: actionContainer(context, () {
                      Navigator.of(context)
                          .pushNamed(addEditAddress,
                              arguments:
                                  addressList?.defaultShippingAddressId?.url)
                          .then((value) {
                        if (value == true) {
                          _dashboardBloc?.add(DashboardAddressFetchEvent());
                        }
                      });
                    }, () {
                      shippingAddressModelBottomSheet(context, (addressId) {
                        showAddressPage = false;
                        _dashboardBloc
                            ?.add(SaveShippingAddress(addressId.toString()));
                      }, addressList);
                      _dashboardBloc?.add(const ChangeAddressEvent());
                    },
                        iconLeft: Icons.edit,
                        titleLeft:
                            _localizations?.translate(AppStringConstant.edit),
                        titleRight: _localizations
                            ?.translate(AppStringConstant.changeAddress),
                        iconRight: Icons.track_changes)),
                const Spacer(),
                Container(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.all(AppSizes.imageRadius),
                    child: commonButton(context, () {
                      Navigator.of(context).pushNamed(addressBook);
                    },
                        _localizations
                                ?.translate(AppStringConstant.manageAddress) ??
                            '',
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        textColor:
                        Theme.of(context).colorScheme.secondaryContainer))


              ],
            ),
          )
        : lottieAnimation(
            context,
            "lib/assets/lottie/empty_address.json",
            _localizations?.translate(AppStringConstant.noAddress) ?? '',
            _localizations?.translate(AppStringConstant.noAddressMessage) ?? "",
            _localizations?.translate(AppStringConstant.addNewAddress) ?? '',
            () {
            Navigator.of(context)
                .pushNamed(addEditAddress, arguments: billingAddressUrl)
                .then((value) {
              if (value == true) {
                _dashboardBloc?.add(DashboardAddressFetchEvent());
              }
            });
          });
  }

  Addresses? getDefaultBillingAddress() {
    Addresses? billingAddress;
    for (Addresses a in addressList?.addresses ?? []) {
      if (a.addressId == addressList?.customerId) {
        billingAddress = a;
        billingAddressUrl = billingAddress.url;
        return billingAddress;
      }
    }
    return billingAddress;
  }

  Tab _getTab(title) {
    return Tab(
      child: Container(
        width: AppSizes.width / 3,
        height: AppSizes.height / 20,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.extraPadding),
        color: Theme.of(context).cardColor,
        child: Center(
            child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        )),
      ),
    );
  }
}
