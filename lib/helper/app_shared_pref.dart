import 'dart:io';

import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:get_storage/get_storage.dart';

class AppSharedPref {
  //==========Shared Preference Keys===========//
  String loginKey = "loginKey";
  String isLogin = "false";
  String appLanguage = "appLanguage";
  String firstLang = "firstLang";
  String splashData = "splashData";
  String user = "user";
  String emailKey = "emailKey";
  String themeMode = "themeMode";
  String notification = "notification";
  // String isVisitingWithoutLogin = "isVisitingWithoutLogin";
  String userdata = "userdata";
  String socialLoginStatus = "socialLoginStatus";

  //---------------Global Keys--------------//
  String fingerPrinfLoginData = "fingerprintLoginData";

  // String firebaseToken = "firebaseToken";
  String deviceId = "deviceId";

  //=========================================//
  GetStorage userStorage =
  GetStorage("userRelatedData"); //---Use if info related to user only
  GetStorage globalStorage =
  GetStorage("globalStorage"); //-----Use if info not dependent on user

  //-------Used to initialized storage boxes for initial values
  Future<bool> init() async {
    await GetStorage.init("userRelatedData");
    await GetStorage.init("globalStorage");
    return true;
  }

  setLoginKey(String login_key) {
    userStorage.write(loginKey, login_key);
  }

  String? getLoginKey() {
    print(userStorage.read(loginKey));
    return userStorage.read(loginKey);
  }

  setIfLogin(bool? is_login) {
    userStorage.write(isLogin, is_login);
  }

  bool? getIfLogin() {
    return userStorage.read(isLogin);
  }

  setNotification(bool? isShow){
    userStorage.write(notification,isShow );
  }

  bool? getNotification(){
    return userStorage.read(notification);
  }

  // setThemeMode(bool? isDarkTheme) {
  //   print("WRITE MODE---$isDarkTheme");
  //   userStorage.write(themeMode, isDarkTheme);
  // }
  //
  // bool? getThemeMode() {
  //   var value = userStorage.read(themeMode);
  //   print("READ MODE---$value");
  //   return value;
  // }

  logoutUser() {
    userStorage.erase();
  }



  setSplashData(SplashScreenModel? splashModel) {
    userStorage.write(splashData, splashModel);
  }

  SplashScreenModel? getSplashData() {
    return userStorage.read(splashData);
  }

  setUserData(UserDataModel? userDataModel) {
    userStorage.write(userdata, userDataModel?.toJson());
  }

  setIsSocialLogin(bool isSocialLogin) {
    userStorage.write(socialLoginStatus, isSocialLogin);
  }

  bool getIsSocialLogin() {
    return userStorage.read(socialLoginStatus) ?? false;
  }

  UserDataModel? getUserData() {
    var userMap = userStorage.read(userdata);
    if (userMap != null) {
      return UserDataModel.fromJson(userMap);
    }
    return null;
  }

//=============================================//
  setFingerPrintData(String savedKey) {
    globalStorage.write(fingerPrinfLoginData, savedKey);
  }

  String? getFingerPrintData() {
    return globalStorage.read(fingerPrinfLoginData);
  }

  setDeviceID(String id) {
    globalStorage.write(deviceId, id);
    print("deviceId---Write>>${globalStorage.read(deviceId)}");
  }

  String? getDeviceID() {
    print("deviceId--Read->>${globalStorage.read(deviceId)}");
    return globalStorage.read(deviceId);
  }


  setAppLanguage(String language) {
    globalStorage.write(appLanguage, language);
    print("AppLanguage---Write>>${globalStorage.read(appLanguage)}");
  }

  String? getAppLanguage() {
    print("AppLangauage--Read->>${globalStorage.read(appLanguage)}");
    return globalStorage.read(appLanguage);  }

  setThemeMode(bool? isDarkTheme) {
    globalStorage.write(themeMode, isDarkTheme);
    print("WRITE MODE---$isDarkTheme");
  }

  bool? getThemeMode() {
    var value = globalStorage.read(themeMode);
    print("READ MODE---$value");
    return value;
  }
  setFirstLang(bool isFirst) {
    globalStorage.write(firstLang, isFirst);
  }
  bool getFirstLang() {
    return globalStorage.read(firstLang)?? false;  }


}
