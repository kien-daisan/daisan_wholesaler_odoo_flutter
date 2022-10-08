import 'dart:convert';

import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../helper/app_shared_pref.dart';
import '../../../helper/push_notifications_manager.dart';

abstract class HomeScreenRepository {
  Future<HomePageData> getHomeData();
}

class HomeScreenRepositoryImp implements HomeScreenRepository {
  @override
  Future<HomePageData> getHomeData() async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print(firebaseToken);
    Map<String, dynamic> data = {};
    data['fcmToken'] = firebaseToken;
    data['customerId'] = "";
    data['fcmDeviceId'] = AppSharedPref().getDeviceID() ?? "";
    String bodyData = json.encode(data);
    HomePageData? model;
   model = await ApiClient().getHomePageData(generateEncodedApiKey(ApiConstant.baseData), bodyData);
    return model;
  }
}
