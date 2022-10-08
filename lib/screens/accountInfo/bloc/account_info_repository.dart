import 'dart:convert';

import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../helper/app_shared_pref.dart';
import '../../../helper/encryption.dart';
import '../../../helper/push_notifications_manager.dart';

abstract class AccountInfoRepository {
  Future<AccountInfoModel> saveAccountInfo(String name, String password);

  Future<AccountInfoModel> deactivateAccount(String type);

  Future<AccountInfoModel> downloadAccountInfo();

  Future<BaseModel> resendVerificationMail();

  Future<LoginResponseModel> loginUser(String email, String password);

  Future<BaseModel> deleteAccount();
}

class AccountInfoRepositoryImp implements AccountInfoRepository {
  @override
  Future<AccountInfoModel> deactivateAccount(String type) async {
    AccountInfoModel? model;
    Map<String, dynamic> data = {};
    data["type"] = type;
    String body = json.encode(data);
    model = await ApiClient().deactivateAccount(body);
    return model;
  }

  @override
  Future<AccountInfoModel> downloadAccountInfo() async {
    AccountInfoModel? model;
    model = await ApiClient().downloadInfo();
    return model;
  }

  @override
  Future<AccountInfoModel> saveAccountInfo(String name, String password) async {
    AccountInfoModel? model;
    Map<String, dynamic> data = {};
    data["name"] = name;
    if (password != '') {
      data["password"] = password;
    }
    String body = json.encode(data);
    model = await ApiClient().saveAccountInfo(body);
    if (model.success == true && password != '') {
      Map<String, dynamic> header = {};
      header["login"] = AppSharedPref().getUserData()?.email;
      header["pwd"] = password;
      String key = generateEncodedApiKey(json.encode(header));
      AppSharedPref().setLoginKey(key);
    }
    return model;
  }

  @override
  Future<BaseModel> resendVerificationMail() async {
    BaseModel? model;
    model = await ApiClient().resendVerification();
    return model;
  }

  @override
  Future<LoginResponseModel> loginUser(String email, String password) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print(firebaseToken);
    Map<String, dynamic> header = {};
    Map<String, dynamic> data = {};
    header["login"] = email;
    header["pwd"] = password;
    data['fcmToken'] = firebaseToken;
    data['customerId'] = "";
    data['fcmDeviceId'] = AppSharedPref().getDeviceID() ?? "";
    String headerData = json.encode(header);
    String bodyData = json.encode(data);
    String key = generateEncodedApiKey(headerData);
    var model = await ApiClient().getCustomerLogIn(key, bodyData, "text/plain");
    if (model.success == true) {
      AppSharedPref().setLoginKey(key);
    }
    return model;
  }

  @override
  Future<BaseModel> deleteAccount() async {
    BaseModel? model;
    model = await ApiClient().deleteAccount("");
    return model;
  }
}
