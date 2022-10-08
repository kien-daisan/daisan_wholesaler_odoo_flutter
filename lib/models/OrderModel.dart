import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'HomeScreenModel.dart';
 part 'OrderModel.g.dart';
@JsonSerializable()
class OrderModel extends BaseModel{
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
int? tcount;
List<RecentOrders>? recentOrders;

OrderModel({
  this.customerId,
  this.userId,
  this.addons,
  this.cartCount,
  this.isEmailVerified,
  this.isSeller,
  this.itemsPerPage,
  this.recentOrders,
  this.sellerGroup,
  this.sellerState,
  this.tcount,
  this.wishlistCount
});
factory OrderModel.fromJson(Map<String, dynamic> json) =>
    _$OrderModelFromJson(json);

Map<String, dynamic> toJson() => _$OrderModelToJson(this);


}


@JsonSerializable()
class RecentOrders{
  @JsonKey(name: "amount_total")
  String? amountTotal;
  bool? canReOrder;
  @JsonKey(name:"create_date")
  String? createDate;
  int? id;
  String? name;
  @JsonKey(name: "shipAdd_url")
  String? shippingAddressUrl;
  @JsonKey(name: "shipping_address")
  String? shippingAddress;
  String? status;
  String? url;

  RecentOrders({
    this.url,
    this.name,
    this.id,
    this.amountTotal,
    this.canReOrder,
    this.createDate,
    this.shippingAddress,
    this.shippingAddressUrl,
    this.status
});
  factory RecentOrders.fromJson(Map<String, dynamic> json) =>
      _$RecentOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$RecentOrdersToJson(this);

}