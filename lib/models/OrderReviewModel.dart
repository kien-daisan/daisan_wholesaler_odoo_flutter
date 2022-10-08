import 'BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HomeScreenModel.dart';
part 'OrderReviewModel.g.dart';

@JsonSerializable()
class OrderReviewModel extends BaseModel{
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  PaymentTerms? paymentTerms;
  String? name;
  String? billingAddress;
  String? shippingAddress;
  String? paymentAcquirer;
  Subtotal? subtotal;
  Subtotal? tax;
  Subtotal? grandtotal;
  double? amount;
  String? currency;
  List<Items>? items;
  Delivery? delivery;
  PaymentData? paymentData;
  @JsonKey(name: "transaction_id")
  int? transactionId;

  OrderReviewModel(
      {
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.paymentTerms,
        this.name,
        this.billingAddress,
        this.shippingAddress,
        this.paymentAcquirer,
        this.subtotal,
        this.tax,
        this.grandtotal,
        this.amount,
        this.currency,
        this.items,
        this.delivery,
        this.paymentData,
        this.transactionId});

  factory OrderReviewModel.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewModelFromJson(json);

}



@JsonSerializable()
class PaymentTerms {
  String? paymentShortTerms;
  String? paymentLongTerms;

  PaymentTerms({this.paymentShortTerms, this.paymentLongTerms});

  factory PaymentTerms.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermsFromJson(json);

}

@JsonSerializable()
class Subtotal {
  String? title;
  String? value;

  Subtotal({this.title, this.value});

  factory Subtotal.fromJson(Map<String, dynamic> json) =>
      _$SubtotalFromJson(json);

}

@JsonSerializable()
class Items {
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


@JsonSerializable()
class Delivery {
  List<String>? tax;
  String? name;
  String? description;
  int? shippingId;
  String? total;

  Delivery(
      {this.tax, this.name, this.description, this.shippingId, this.total});

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);

}


@JsonSerializable()
class PaymentData {
  bool? status;
  String? code;
  bool? auth;
  @JsonKey(name: "customer_email")
  String? customerEmail;

  PaymentData({this.status, this.code, this.auth, this.customerEmail});

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

}