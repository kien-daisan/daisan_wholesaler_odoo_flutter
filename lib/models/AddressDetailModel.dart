import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddressDetailModel.g.dart';

@JsonSerializable()
class AddressDetailModel extends BaseModel {
  int? itemsPerPage;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @JsonKey(name: "is_seller")
  bool? isSeller;
  String? name;
  String? street;
  String? zip;
  String? city;
  @JsonKey(name: "state_id")
  var stateId;
  @JsonKey(name: "country_id")
  var countryId;
  String? phone;

  AddressDetailModel(
      {this.itemsPerPage,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.isSeller,
      this.name,
      this.street,
      this.zip,
      this.city,
      this.stateId,
      this.countryId,
      this.phone});

  factory AddressDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AddressDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailModelToJson(this);
}
int fromJson(dynamic json){
  int stateId = -1;
  if(json != null){
    if(json['state_id'] != null){
      stateId = json['state_id'];
    }
  }
  return stateId;
}
