import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'HomeScreenModel.dart';

part 'CartViewModel.g.dart';

@JsonSerializable()
class CartViewModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  String? name;
  Subtotal? subtotal;
  Subtotal? tax;
  Subtotal? grandtotal;
  List<Items>? items;

  CartViewModel(
      {
        this.itemsPerPage,
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.name,
        this.subtotal,
        this.tax,
        this.grandtotal,
        this.items});

  factory CartViewModel.fromJson(Map<String, dynamic> json) =>
      _$CartViewModelFromJson(json);
}

@JsonSerializable()
class Subtotal{
  String? title;
  String? value;

  Subtotal({this.title, this.value});

  factory Subtotal.fromJson(Map<String, dynamic> json) =>
      _$SubtotalFromJson(json);
}

@JsonSerializable()
class Items{
  int? lineId;
  int? templateId;
  String? name;
  String? thumbNail;
  String? priceReduce;
  String? priceUnit;
  double? qty;
  String? total;
  String? discount;

  Items(
      {this.lineId,
        this.templateId,
        this.name,
        this.thumbNail,
        this.priceReduce,
        this.priceUnit,
        this.qty,
        this.total,
        this.discount});

  factory Items.fromJson(Map<String, dynamic> json) =>
      _$ItemsFromJson(json);
}