import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HomeScreenModel.dart';
part 'WishlistModel.g.dart';


@JsonSerializable()
class WishlistModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  bool? isEmailVerified;
  List<WishListItems>? wishLists;

  WishlistModel(
      {
        this.itemsPerPage,
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.wishLists});

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);
}



@JsonSerializable()
class WishListItems{
  int? id;
  String? name;
  String? thumbNail;
  String? priceReduce;
  String? priceUnit;
  int? productId;
  int? templateId;

  WishListItems(
      {this.id,
        this.name,
        this.thumbNail,
        this.priceReduce,
        this.priceUnit,
        this.productId,
        this.templateId});

  factory WishListItems.fromJson(Map<String, dynamic> json) =>
      _$WishListItemsFromJson(json);

}