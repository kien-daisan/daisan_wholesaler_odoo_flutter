import 'package:flutter_project_structure/models/BaseModel.dart';
import 'HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PaymentModel.g.dart';

@JsonSerializable()
class PaymentModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  int? customerId;
  int? userId;
  int? cartCount;
  int? wishlistCount;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  List<Acquirers>? acquirers;

  PaymentModel(
      {
        this.itemsPerPage,
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.acquirers});

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}


@JsonSerializable()
class Acquirers{
  int? id;
  String? name;
  String? thumbNail;
  String? description;
  String? code;
  String? extraKey;

  Acquirers(
      {this.id,
        this.name,
        this.thumbNail,
        this.description,
        this.code,
        this.extraKey});

  factory Acquirers.fromJson(Map<String, dynamic> json) =>
      _$AcquirersFromJson(json);
}


