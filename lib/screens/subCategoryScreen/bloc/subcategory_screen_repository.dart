import 'dart:convert';

import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class SubCategoryRepository{
  Future<CategoryScreenModel> getCategoryPage(int cid, int limit, int offset);
}

class SubCategoryRepositoryImp implements SubCategoryRepository{
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

}