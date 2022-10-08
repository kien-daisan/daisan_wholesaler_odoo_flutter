import 'dart:convert';

import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/helper/push_notifications_manager.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/models/SocialLoginModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../models/LoginResponseModel.dart';

abstract class SigninSignupScreenRepository {
  Future<SignUpScreenModel>? signUp(String email, String password, String name );

  Future login(String email, String password);

  Future<LoginResponseModel>? fingerPrintLogin(String loginKey);

  Future forgotPassword(String email);

  Future socialLogin(SocialLoginModel socialLoginRequest);

  Future<SignUpTermsModel> getSignUpTerms();

  Future<CountryListModel> getCountryList();

  Future<SignUpTermsModel> getSellerSignUpTerms();
}

class SigninSignupScreenRepositoryImp implements SigninSignupScreenRepository {
  @override
  Future<SignUpScreenModel>? signUp(
      String email, String password, String name ) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    Map<String, dynamic> data = {};
    data["login"] = email;
    data["password"] = password;
    data["name"] = name;
    data['fcmToken'] = firebaseToken;
    data['customerId'] = "";
    data['fcmDeviceId'] = AppSharedPref().getDeviceID() ?? "";
    String body = json.encode(data);
    SignUpScreenModel model = await ApiClient().getCustomerSignUp(body);
    if (model.success == true) {
      Map<String, dynamic> header = {};
      header["login"] = email;
      header["pwd"] = password;
      String headerData = json.encode(header);
      String key = generateEncodedApiKey(headerData);
      AppSharedPref().setLoginKey(key);
    }
    return model;
  }

  @override
  Future forgotPassword(String email) async {
    Map<String, dynamic> data = {};
    data["login"] = email;
    String body = json.encode(data);
    BaseModel? model = await ApiClient().forgetPassword(body);
    return model;
  }

  @override
  Future login(String email, String password) async {
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
  Future<LoginResponseModel>? fingerPrintLogin(String loginKey) async {
    var model = await ApiClient().getCustomerLogIn(loginKey, "", "");
    if (model.success == true) {
      AppSharedPref().setLoginKey(loginKey);
    }
    return model;
  }

  @override
  Future socialLogin(SocialLoginModel socialLoginRequest) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    Map<String, dynamic> data = {};
    data["name"] =
        "${socialLoginRequest.firstName} ${socialLoginRequest.lastName}";
    data["login"] = socialLoginRequest.email;
    data["password"] = socialLoginRequest.id;
    data['isSocialLogin'] = true;
    data['authUserId'] = socialLoginRequest.id;
    data['authProvider'] = socialLoginRequest.authProvider;
    data['authToken'] = socialLoginRequest.token;
    data['fcmToken'] = firebaseToken;
    data['fcmDeviceId'] = AppSharedPref().getDeviceID() ?? "";

    String body = json.encode(data);
    SignUpScreenModel? model = await ApiClient().getCustomerSignUp(body);
    if (model.success == true) {
      AppSharedPref().setIsSocialLogin(true);
      AppSharedPref().setUserData(UserDataModel(
          name:
              "${socialLoginRequest.firstName} ${socialLoginRequest.lastName}",
          email: socialLoginRequest.email));
      Map<String, dynamic> header = {};
      // header["mAuthProvider"] = socialLoginRequest.authProvider.toString().toUpperCase();
      // header["mAuthUserId"] = socialLoginRequest.id;
      // header["mIsSocialLogin"] = true;
      header["login"] = socialLoginRequest.email;
      header["pwd"] = socialLoginRequest.id;
      String headerData = json.encode(header);
      print("sadasd===${headerData}");
      String key = generateEncodedApiKey(headerData);
      AppSharedPref().setLoginKey(key);
    }
    return model;
  }

  @override
  Future<SignUpTermsModel> getSignUpTerms()async{
    SignUpTermsModel model = await ApiClient().getSignUpTerms();
    return model;
  }

  @override
  Future<CountryListModel> getCountryList() async {
    CountryListModel model;
    model = await ApiClient().getCountryList();
    return model;
  }
  @override
  Future<SignUpTermsModel> getSellerSignUpTerms()async{
    SignUpTermsModel model = await ApiClient().getSignUpTerms();
    return model;
  }

}
