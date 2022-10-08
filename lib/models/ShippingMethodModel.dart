
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ShippingMethodModel.g.dart';

@JsonSerializable()
class ShippingMethodModel extends BaseModel {
  int? itemsPerPage;
  int? customerId;
  int? userId;
  int? cartCount;
  @JsonKey(name: "WishlistCount")
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @JsonKey(name: "ShippingMethods")
  List<ShippingMethods>? shippingMethods;
 
  ShippingMethodModel(
      {this.itemsPerPage,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.shippingMethods});

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodModelToJson(this);
}

@JsonSerializable()
class ShippingMethods {
  String? name;
  int? id;
  String? description;
  String? price;

  ShippingMethods({this.name, this.id, this.description, this.price});

  factory ShippingMethods.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodsToJson(this);
}
