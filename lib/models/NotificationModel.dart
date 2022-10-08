import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
 part 'NotificationModel.g.dart';


@JsonSerializable()
class NotificationModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @JsonKey(name: "is_seller")
  bool? isSeller;
  @JsonKey(name: "seller_group")
  String? sellerGroup;
  @JsonKey(name: "seller_state")
  String? sellerState;
  @JsonKey(name: "all_notification_messages")
  List<NotificationList>? notificationList;

  NotificationModel({this.userId,this.addons, this.cartCount, this.isEmailVerified, this.isSeller, this.sellerGroup, this.sellerState, this.wishlistCount, this.itemsPerPage, this.customerId, this.notificationList});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String,dynamic> toJson() => _$NotificationModelToJson(this);


}

@JsonSerializable()
class NotificationList{
int? id;
String? name;
String? title;
String?subtitle;
String? body;
String? banner;
String? icon;
String? period;
@JsonKey(name: "datatype")
String? dataType;
@JsonKey(name: "is_reade")
bool? isRead;

NotificationList({this.body, this.name,this.id,this.icon,this.title,this.banner,this.dataType,this.isRead,this.period,this.subtitle});

factory NotificationList.fromJson(Map<String, dynamic> json) =>
    _$NotificationListFromJson(json);

Map<String, dynamic> toJson() => _$NotificationListToJson(this);


}