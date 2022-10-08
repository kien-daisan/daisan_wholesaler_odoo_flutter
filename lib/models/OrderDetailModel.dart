import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'OrderDetailModel.g.dart';

@JsonSerializable()
class OrderDetailModel extends BaseModel {
  int? itemsPerPage;
  Addons? addons;
  int? customerId;
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
  @JsonKey(name: "seller_tate")
  String? sellerState;
  String? name;
  @JsonKey(name: "create_date")
  String? createDate;
  @JsonKey(name: "amount_total")
  String? amountTotal;
  String? status;
  @JsonKey(name: "amount_untaxed")
  String? amountUntaxed;
  @JsonKey(name: "amount_tax")
  String? amountTax;
  @JsonKey(name: "shipping_address")
  String? shippingAddress;
  @JsonKey(name: "shipAdd_url")
  String? shipAddUrl;
  @JsonKey(name: "billing_address")
  String? billingAddress;
  List<OrderItems>? items;
  Delivery? delivery;

  OrderDetailModel(
      {this.itemsPerPage,
      this.addons,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.isSeller,
      this.sellerGroup,
      this.sellerState,
      this.name,
      this.createDate,
      this.amountTotal,
      this.status,
      this.amountUntaxed,
      this.amountTax,
      this.shippingAddress,
      this.shipAddUrl,
      this.billingAddress,
      this.items,
      this.delivery});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}

@JsonSerializable()
class OrderItems {
  String? name;
  @JsonKey(name: "product_name")
  String? productName;
  String? qty;
  @JsonKey(name: "price_unit")
  String? priceUnit;
  @JsonKey(name: "price_subtotal")
  String? priceSubtotal;
  @JsonKey(name: "price_tax")
  String? priceTax;
  @JsonKey(name: "price_total")
  String? priceTotal;
  String? discount;
  String? state;
  String? thumbNail;
  int? templateId;

  OrderItems(
      {this.name,
      this.productName,
      this.qty,
      this.priceUnit,
      this.priceSubtotal,
      this.priceTax,
      this.priceTotal,
      this.discount,
      this.state,
      this.thumbNail,
      this.templateId});

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}
