import 'dart:convert';

import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/app_shared_pref.dart';
import '../../../helper/encryption.dart';
import '../../../helper/push_notifications_manager.dart';
import '../../../models/HomeScreenModel.dart';

abstract class CategoryScreenRepository {
  Future<CategoryScreenModel> getCategoryPage(int cid, int limit, int offset);

  Future<HomePageData> getHomeData();
}

class CategoryScreenRepositoryImp implements CategoryScreenRepository {
  @override
  Future<CategoryScreenModel> getCategoryPage(
      int cid, int limit, int offset) async {
    CategoryScreenModel? model;
    Map<String, dynamic> data = {};
    data["cid"] = cid;
    data["limit"] = limit;
    data["offset"] = offset;

    String body = json.encode(data);
    print(body);
    model = await ApiClient().getCatalogData(body);
    return model;
  }

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
