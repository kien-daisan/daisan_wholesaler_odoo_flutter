import 'dart:convert';

import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class CatalogScreenRepository{
  Future<CategoryScreenModel> getCategoryPage(int cid, int limit, int offset);
  Future<CategoryScreenModel> getCatalogDatafromHome(String url, int limit, int offset);
  Future<CategoryScreenModel> getCatalogDataFromNotification(int limit, String domain);

  }

class CategoryScreenRepositoryImp implements CatalogScreenRepository{
  @override
  Future<CategoryScreenModel> getCategoryPage(int cid, int limit, int offset) async {
    CategoryScreenModel? model;
    Map<String, dynamic> data ={};
    data["cid"] = cid;
    data["limit"] = limit;
    data["offset"] = offset;

    String body = json.encode(data);
    print(body);
    model = await ApiClient().getCatalogData(body);
    return model;
  }

  @override
  Future<CategoryScreenModel> getCatalogDatafromHome(String url, int limit, int offset) async{
    CategoryScreenModel? model;
    Map<String, dynamic> data ={};
    data["limit"] = limit;
    data["offset"] = offset;
    String body = json.encode(data);
    model = await ApiClient().getProductSliderData(url, body, "text/plain");
    return model;
  }

  @override
  Future<CategoryScreenModel> getCatalogDataFromNotification( int limit, String domain) async{
    CategoryScreenModel? model;
    Map<String, dynamic> data ={};
    data["limit"] = limit;
    data["domain"] = domain;
    String body = json.encode(data);
    print(body);
    model = await ApiClient().getCatalogData(body);
    return model;
  }

}