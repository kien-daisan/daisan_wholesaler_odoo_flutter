import 'dart:convert';

import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class SearchRepository{
Future<SearchScreenModel> getSearchSuggestion(String text);
}

class SearchRepositoryImp implements SearchRepository{
  @override
  Future<SearchScreenModel> getSearchSuggestion(String text) async{
    SearchScreenModel? model;
    Map<String, dynamic> data ={};
    data["offset"] = 0;
    data['limit'] = 20;
    data["search"] = text;
    String body = json.encode(data);
    model = await ApiClient().getSearchList( body);
    return model;
  }

}