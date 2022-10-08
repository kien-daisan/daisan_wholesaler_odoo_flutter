import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddressListModel.g.dart';

@JsonSerializable()
class AddressListModel extends BaseModel {
  int? itemsPerPage;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  int? tcount;
  List<Addresses>? addresses;
  @JsonKey(name: "default_shipping_address_id")
  Addresses? defaultShippingAddressId;

  AddressListModel(
      {this.itemsPerPage,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.tcount,
      this.addresses,
      this.defaultShippingAddressId});

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      _$AddressListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressListModelToJson(this);
}

@JsonSerializable()
class Addresses {
  String? name;
  String? url;
  int? addressId;
  @JsonKey(name: "display_name")
  String? displayName;

  Addresses({this.name, this.url, this.addressId, this.displayName});

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesToJson(this);
}
