import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/profile/view/privacy_policy.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../config/theme.dart';
import '../../../main.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  _SettingsBottomSheetState createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet>
    with WidgetsBindingObserver {
  AppLocalizations? _localizations;
  SplashScreenModel? model;
  bool? isNotificationOn = AppSharedPref().getNotification();
  bool? isDarkModeOn = AppSharedPref().getThemeMode() ?? ((MyApp.themeNotifier.value == ThemeMode.dark) ? true : false);

  @override
  void initState() {
    super.initState();
    model = AppSharedPref().getSplashData();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.notification.isGranted == true) {
        print("granted");
        setState(() {
          isNotificationOn = true;
          AppSharedPref().setNotification(true);
        });
      } else if (await Permission.notification.isDenied == true) {
        print("denied");
        setState(() {
          isNotificationOn = false;
          AppSharedPref().setNotification(false);

        });
      }
    }

    super.didChangeAppLifecycleState(state);
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
          _localizations?.translate(AppStringConstant.setting) ?? "", context,
          isLeadingEnable: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  showSettingTile(
                      _localizations
                              ?.translate(AppStringConstant.notifications) ??
                          "",
                      true,
                      context,
                      callback: (isOn) {
                    openAppSettings();
                  }, isOn: isNotificationOn ?? true),
                  showSettingTile(
                      _localizations?.translate(AppStringConstant.darkMode) ??
                          "",
                      true,
                      context, callback: (isOn) {
                    setState(() {
                      isDarkModeOn = isOn;
                      isDarkModeOn = !(isDarkModeOn ?? false);
                      if (isDarkModeOn ?? false) {
                        MyApp.themeNotifier.value = ThemeMode.dark;
                        AppSharedPref().setThemeMode(true);
                      } else {
                        MyApp.themeNotifier.value = ThemeMode.light;
                        AppSharedPref().setThemeMode(false);
                      }

                    });
                  }, isOn: isDarkModeOn ?? false),
                  Visibility(
                    visible: (model?.privacyPolicyUrl is String),
                    child: GestureDetector(
                      child: showSettingTile(
                          _localizations
                                  ?.translate(AppStringConstant.privacyPolicy) ??
                              "",
                          false,
                          context),
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PrivacyPolicy(model?.privacyPolicyUrl)));
                      },
                    ),
                  )
                ],
              ),
            ),
            commonButton(context, () async {
              openAppSettings();
            },
                (_localizations?.translate(
                            AppStringConstant.manageDeviceSettings) ??
                        "")
                    .toUpperCase(),
                width: AppSizes.width - 20,
                height: AppSizes.itemHeight)
          ],
        ),
      ),
    );
  }
}

// void showSettingsBottomSheet(BuildContext context, AppLocalizations? _localizations){
//   bool isNotificationOn = true;
//   bool? isDarkModeOn = AppSharedPref().getThemeMode();
//
//   showMyModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context){
//         return StatefulBuilder(
//           builder: (BuildContext context, void Function(void Function()) setState) {
//             return Scaffold(
//               appBar: commonToolBar(_localizations?.translate(AppStringConstant.setting) ?? "", context, isLeadingEnable: true),
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           showSettingTile(_localizations?.translate(AppStringConstant.notifications) ?? "",true,context,callback: (isOn){
//                             setState((){
//                               // isNotificationOn = isOn;
//                               // isNotificationOn = !isNotificationOn;
//                               openAppSettings().then((value) =>{
//                                 Permission.notification.request().then((value) => {
//                                   print("value$value"),
//                                   if(value == PermissionStatus.granted){
//                                     isNotificationOn = isOn
//                                   }else{
//                                     isNotificationOn = !isOn
//                                   }
//                                 })
//                               });
//
//                             });
//
//                           }, isOn: isNotificationOn,),
//                           showSettingTile(_localizations?.translate(AppStringConstant.darkMode) ?? "",true,context,callback: (isOn){
//                             setState((){
//                               isDarkModeOn = isOn;
//                               isDarkModeOn = !(isDarkModeOn??false);
//                               if(isDarkModeOn??false){
//                                 MyApp.themeNotifier.value = ThemeMode.dark;
//                                 AppSharedPref().setThemeMode(isDarkModeOn);
//                               }else{
//                                 MyApp.themeNotifier.value = ThemeMode.light;
//                                 AppSharedPref().setThemeMode(!(isDarkModeOn??false));
//                               }
//                             });
//                           },isOn: isDarkModeOn??false),
//                           GestureDetector(
//                               child: showSettingTile(_localizations?.translate(AppStringConstant.privacyPolicy) ?? "", false, context),
//                             onTap: (){
//                               SplashScreenModel? model =  AppSharedPref().getSplashData();
//                              Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy(model?.privacyPolicyUrl)));
//                             },
//                           )
//
//                         ],
//                       ),
//                     ),
//                     commonButton(context, () async{
//                         openAppSettings();
//                     }, (_localizations?.translate(AppStringConstant.manageDeviceSettings) ?? "").toUpperCase(),width: AppSizes.width-20,height: AppSizes.itemHeight)
//                   ],
//                 ),
//               ),
//             );
//           },
//
//         );
//       });
//
//
//
//
// }
Widget showSettingTile(
  String title,
  bool showToggleButton,
  BuildContext context, {
  final ValueChanged<bool>? callback,
  bool isOn = false,
}) {
  return Container(
    color: Theme.of(context).cardColor,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              showToggleButton
                  ? Switch(
                      activeColor: MobikulTheme.accentColor,
                      value: isOn,
                      onChanged: (value) {
                        callback!(isOn);
                      })
                  : Container(height: 50)
            ],
          ),
        ),
        const Divider(
          thickness: 1.0,
          height: 1.0,
        )
      ],
    ),
  );
}
