import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_event.dart';
import 'package:image_picker/image_picker.dart';
import '../helper/app_localizations.dart';
import '../helper/app_shared_pref.dart';
import '../helper/image_view.dart';
import '../models/UserDataModel.dart';
import '../screens/signin_signup/view/my_bottom_sheet.dart';

class CommonBannerView extends StatefulWidget {
  Function(String, String)? addImageCallback;
  Function(String)? deleteImageCallBack;

  CommonBannerView(this.addImageCallback, this.deleteImageCallBack, {Key? key})
      : super(key: key);

  @override
  _CommonBannerViewState createState() => _CommonBannerViewState();
}

class _CommonBannerViewState extends State<CommonBannerView> {
  String? bannerImage;
  String? profileImage;
  String name = "";
  File? pickedBannerImage;
  File? pickedProfileImage;
  final ImagePicker _picker = ImagePicker();
  AppLocalizations? _localizations;

  @override
  void initState() {
    // UserDataModel? userModel = AppSharedPref.getUserData();
    //   bannerFromNetwork = true;
    //   profileFromNetwork = true;
    //   bannerImage = userModel?.bannerImage;
    //   profileImage = userModel?.profileImage;
    //   name = userModel?.name ?? "";

    super.initState();
  }

  void getDetails() {
    setState(() {
      UserDataModel? userModel = AppSharedPref().getUserData();
      // bannerFromNetwork = true;
      // profileFromNetwork = true;
      bannerImage = userModel?.bannerImage;
      profileImage = userModel?.profileImage;
      name = userModel?.name ?? "";
    });
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getDetails();
    return Container(
        width: AppSizes.width,
        child: commonBannerView(bannerImage, profileImage, name, () {
          setState(() {
            getImageOptions(_localizations
                    ?.translate(AppStringConstant.uploadBannerImage)
                    .toUpperCase() ??
                "");
          });
        }, () {
          setState(() {
            getImageOptions(_localizations
                    ?.translate(AppStringConstant.uploadProfileImage)
                    .toUpperCase() ??
                "");
          });
        }));
  }

  Widget commonBannerView(
      String? bannerImage,
      String? profileImage,
      String name,
      VoidCallback? changeBannerImage,
      VoidCallback changeProfileImage) {
    return Container(
      height: AppSizes.height / 3,
      width: AppSizes.width,
      child: Card(
          elevation: 0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                    bannerImage ?? "",
                  ),
                  fit: BoxFit.fill,
                )),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: MobikulTheme.accentColor,
                                    width: 2.0)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: ImageView(
                                  url: profileImage,
                                  fit: BoxFit.fill,
                                ))),
                        Positioned(
                            right: 2.0,
                            child: GestureDetector(
                              onTap: changeProfileImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle,
                                ),
                                height: 25,
                                width: 25,
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.mediumPadding),
                      child: Text(
                        "${_localizations?.translate(AppStringConstant.hello) ?? ''} " +
                            name +
                            "!",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 10.0,
                right: 10.0,
                child: GestureDetector(
                  onTap: changeBannerImage,
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 23,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future getImageOptions(String heading) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.normalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.extraPadding),
                    child: Text(
                      heading,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  optionTile(
                      (_localizations?.translate(AppStringConstant.addImage) ??
                          ""), () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: AppSizes.height / 7,
                            width: AppSizes.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          final XFile? image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          setState(() {
                                            if (heading ==
                                                (_localizations
                                                    ?.translate(
                                                    AppStringConstant
                                                        .uploadBannerImage)
                                                    .toUpperCase() ??
                                                    "")) {
                                              pickedBannerImage =
                                                  File(image?.path ?? "");
                                              final bytes = pickedBannerImage
                                                  ?.readAsBytesSync();
                                              String img64 =
                                              base64Encode(bytes!);
                                              widget.addImageCallback!(img64,
                                                  AppConstant.userBannerImage);
                                            } else {
                                              pickedProfileImage =
                                                  File(image?.path ?? "");
                                              final bytes = pickedProfileImage
                                                  ?.readAsBytesSync();
                                              String img64 =
                                              base64Encode(bytes!);
                                              widget.addImageCallback!(img64,
                                                  AppConstant.profileImage);
                                            }

                                            Navigator.of(context).pop();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.browse_gallery_outlined,
                                          size: 25,
                                        )),
                                    Text(
                                      _localizations
                                          ?.translate(
                                          AppStringConstant.gallery)
                                          .toUpperCase() ??
                                          "",
                                      style:
                                      Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop;
                                          final XFile? photo =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                          setState(() {
                                            Navigator.of(context).pop();
                                            if (heading ==
                                                (_localizations
                                                    ?.translate(
                                                    AppStringConstant
                                                        .uploadBannerImage)
                                                    .toUpperCase() ??
                                                    "")) {
                                              // bannerFromNetwork = false;
                                              pickedBannerImage =
                                                  File(photo?.path ?? "");
                                              final bytes = pickedBannerImage
                                                  ?.readAsBytesSync();
                                              String img64 =
                                              base64Encode(bytes!);
                                              widget.addImageCallback!(img64,
                                                  AppConstant.userBannerImage);
                                            } else {
                                              // profileFromNetwork = false;
                                              pickedProfileImage =
                                                  File(photo?.path ?? "");
                                              final bytes = pickedProfileImage
                                                  ?.readAsBytesSync();
                                              String img64 =
                                              base64Encode(bytes!);
                                              widget.addImageCallback!(img64,
                                                  AppConstant.profileImage);
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.camera)),
                                    Text(
                                        _localizations
                                            ?.translate(
                                            AppStringConstant.camera)
                                            .toUpperCase() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }),
                  optionTile(
                      (_localizations
                          ?.translate(AppStringConstant.deleteImage) ??
                          ""), () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (heading ==
                          (_localizations
                              ?.translate(
                              AppStringConstant.uploadBannerImage)
                              .toUpperCase() ??
                              "")) {
                        widget.deleteImageCallBack!(AppConstant.bannerImage);
                        // bannerFromNetwork=true;
                      } else {
                        widget.deleteImageCallBack!(AppConstant.profileImage);
                        // profileFromNetwork = true;
                      }
                    });
                  }),
                  optionTile(AppStringConstant.cancel, () {
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          );
        }, );
  }

  Widget optionTile(String title, VoidCallback? addAction) {
    return GestureDetector(
      onTap: addAction,
      child: SizedBox(
          height: AppSizes.itemHeight,
          width: AppSizes.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
              const Divider()
            ],
          )),
    );
  }
}
