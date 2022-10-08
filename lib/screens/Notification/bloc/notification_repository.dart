import 'dart:convert';
import 'package:flutter_project_structure/models/NotificationModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class NotificationRepository{
Future<NotificationModel> getNotification();
 Future<NotificationList> markNotification(int id, bool isRead);
Future<NotificationList> deleteNotification(int id);
}

class NotificationRepositoryImp implements NotificationRepository{

  @override
  Future<NotificationModel> getNotification() async {
    NotificationModel model;
    model = await ApiClient().getNotificationData();
    return model;
  }

  @override
  Future<NotificationList> markNotification(int id, bool isRead)async{
    NotificationList model;
    Map<String,dynamic> data = {};
    data["isRead"] = isRead;
    String body = json.encode(data);
    model = await ApiClient().markReadNotification(id.toString(), body);
    return model;
  }

  @override
  Future<NotificationList> deleteNotification(int id) async{
    NotificationList model;
    model = await ApiClient().deleteNotification(id.toString());
    return model;
  }
}