import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SearchScreenModel.g.dart';

@JsonSerializable()
class SearchScreenModel extends BaseModel {
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
  int? offset;
  List<Products>? products;
  SearchScreenModel({
    this.isEmailVerified, this.customerId,this.itemsPerPage, this.wishlistCount,this.sellerState, this.sellerGroup, this.isSeller, this.cartCount,
    this.addons, this.userId, this.offset, this.tcount, this.products
});

  factory SearchScreenModel.fromJson(Map<String, dynamic> json) => _$SearchScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchScreenModelToJson(this);

}


