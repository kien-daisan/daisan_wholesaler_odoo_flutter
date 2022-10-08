import 'dart:convert';

import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class AddReviewRepository {
  Future<BaseModel> addReview(
      int rating, String title, String review, int templateId);
}

class AddReviewRepositoryImp implements AddReviewRepository {
  @override
  Future<BaseModel> addReview(
      int rating, String title, String review, int templateId) async {
    BaseModel? model;
    Map<String, dynamic> data = {};
    data["rate"] = rating;
    data["title"] = title;
    data["detail"] = review;
    data["template_id"] = templateId;
    String body = json.encode(data);
    model = await ApiClient().addReview("text/plain", body);
    return model;
  }
}
