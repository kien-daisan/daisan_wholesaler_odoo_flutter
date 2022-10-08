import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AccountInfoModel.g.dart';

@JsonSerializable()
class AccountInfoModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  int? userId;
  int? cartCount;
  @JsonKey(name: "WishlistCount")
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @JsonKey(name: "is_seller")
  bool? isSeller;
  @JsonKey(name: "seller_group")
  String? sellerGroup;
  @JsonKey(name: "seller_state")
  String? sellerState;
  bool? downloadRequest;
  String? downloadMessage;
  String? downloadUrl;
  String? customerBannerImage;
  String? customerProfileImage;

  AccountInfoModel({this.wishlistCount,this.sellerState,this.downloadRequest,this.sellerGroup,this.isSeller, this.isEmailVerified,this.cartCount,this.addons, this.userId, this.itemsPerPage, this.downloadMessage, this.downloadUrl, this.customerBannerImage, this.customerProfileImage});

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoModelToJson(this);

}