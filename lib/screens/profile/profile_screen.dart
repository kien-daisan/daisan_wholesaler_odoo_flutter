import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_banner_view.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_restart.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/screens/dashboard/views/collapse_appbar.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_event.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_state.dart';
import 'package:flutter_project_structure/screens/profile/view/profile_menu.dart';
import '../../constants/route_constant.dart';
import '../../helper/alert_message.dart';
import '../../models/AccountInfoModel.dart';
import '../../models/ProfileMenuItem.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppLocalizations? _localizations;
  ProfileScreenBloc? profileScreenBloc;
  bool isLoading = false;
  BaseModel? model;
  AccountInfoModel? imageModel;

  @override
  void initState() {
    profileScreenBloc = context.read<ProfileScreenBloc>();
    super.initState();
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
          _localizations?.translate(AppStringConstant.profile) ?? "",
          context),
      body: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
          builder: (context, currentState) {
        if (currentState is LoadingState) {
          isLoading = true;
        } else if (currentState is LogOutSuccess) {
          isLoading = false;
          model = currentState.baseModel;
          AppSharedPref().logoutUser();
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.baseModel?.message ?? '', context);
            // Navigator.pushNamedAndRemoveUntil(
            //     context, splash, (route) => false);
            AppRestart.rebirth(context);
          });
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
          model = currentState.model;
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
          model = currentState.model;
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
        } else if (currentState is ProfileScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }
        return (AppSharedPref().getIfLogin() ?? false)
            ? collapseAppBar(
                context,
                CommonBannerView((image, type) {
                  profileScreenBloc?.add(AddImageEvent(image, type));
                }, (type) {
                  if (type == AppConstant.bannerImage) {
                    profileScreenBloc?.add(const DeleteBannerImageEvent());
                  } else {
                    profileScreenBloc?.add(const DeleteImageEvent());
                  }
                }),
                buildUI())
            : Column(
                children: [
                  profileMenu(
                      _localizations,
                      () {
                        setState(() {});
                      }),
                ],
              );
      }),
    );
  }

  Widget buildUI() {
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            profileMenu(
                _localizations,
                () {
                  setState(() {});
                }),
            signOutTile(context, _localizations, () {
              DialogHelper.confirmationDialog(_localizations?.translate(AppStringConstant.signOutAlert) ?? '',context, _localizations,onConfirm: (){
                profileScreenBloc?.add(LogOutDataFetchEvent());
              }
              );

            })
          ],
        ),
      ),
      Visibility(visible: isLoading, child: Loader())
    ]);
  }
}
