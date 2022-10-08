// ignore_for_file: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HomeScreenModel.dart';

part 'ProductScreenModel.g.dart';

@JsonSerializable()
class ProductScreenModel extends BaseModel {
  int? itemsPerPage;
  Addons? addons;
  int? templateId;
  String? name;
  List<String>? images;
  @JsonKey(name: "avg_rating")
  double? avgRating;
  @JsonKey(name: "total_review")
  int? totalReview;
  String? priceUnit;
  String? priceReduce;
  int? productId;
  int? productCount;
  String? description;
  List<AlternativeProducts>? alternativeProducts;
  @JsonKey(name: "ar_ios")
  String? arIos;
  @JsonKey(name: "ar_android")
  String? arAndroid;
  String? thumbNail;
  String? absoluteUrl;
  bool? addedToWishlist;
  @JsonKey(name: "add_to_cart")
  bool? addToCart;
  @JsonKey(name: "stock_display_msg")
  String? stockDisplayMsg;
  @JsonKey(name: "product_sku")
  String? productSku;
  final List<Attribute>? attributes;
  final List<ProductScreenModel>? variants;
  final List<Combinations>? combinations;

  ProductScreenModel(
      this.templateId,
      this.name,
      this.attributes,
      this.thumbNail,
      this.absoluteUrl,
      this.addedToWishlist,
      this.addToCart,
      this.alternativeProducts,
      this.arAndroid,
      this.arIos,
      this.avgRating,
      this.description,
      this.images,
      this.itemsPerPage,
      this.priceReduce,
      this.priceUnit,
      this.productCount,
      this.productId,
      this.stockDisplayMsg,
      this.totalReview,
      this.variants,
      this.productSku,
      this.combinations);

  factory ProductScreenModel.fromJson(Map<String, dynamic> json) =>
      _$ProductScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductScreenModelToJson(this);
}

@JsonSerializable()
class Attribute {
  int? attributeId;
  String? name;
  String? newVariant;
  String? type;
  List<Values>? values;

  Attribute(
      {this.name, this.type, this.values, this.attributeId, this.newVariant});

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}

@JsonSerializable()
class Values {
  String? name;
  int? valueId;
  String? htmlCode;
  String? newVariant;
  bool? isSelected = false; //----Local Use

  Values({this.newVariant, this.name, this.htmlCode, this.valueId});

  factory Values.fromJson(Map<String, dynamic> json) => _$ValuesFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesToJson(this);
}

@JsonSerializable()
class AlternativeProducts {
  int? templateId;
  String? name;
  String? image;

  AlternativeProducts(this.name, this.image, this.templateId);

  factory AlternativeProducts.fromJson(Map<String, dynamic> json) =>
      _$AlternativeProductsFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeProductsToJson(this);
}

@JsonSerializable()
class Variants {
  int? productId;
  List<String>? images;
  @JsonKey(name: "ar_ios")
  String? arIos;
  @JsonKey(name: "ar_ android")
  String? arAndroid;
  String? absoluteUrl;
  String? priceReduce;
  String? priceUnit;
  List<Combinations>? combinations;
  bool? addedToWishlist;
  @JsonKey(name: "add_to_cart")
  bool? addToCart;
  @JsonKey(name: "stock_display_msg")
  String? stockDisplayMsg;

  Variants(
      {this.productId,
      this.priceReduce,
      this.stockDisplayMsg,
      this.priceUnit,
      this.images,
      this.arIos,
      this.arAndroid,
      this.addToCart,
      this.absoluteUrl,
      this.addedToWishlist,
      this.combinations});

  factory Variants.fromJson(Map<String, dynamic> json) =>
      _$VariantsFromJson(json);

  Map<String, dynamic> toJson() => _$VariantsToJson(this);
}

@JsonSerializable()
class Combinations extends Equatable {
  int? valueId;
  int? attributeId;

  Combinations({this.valueId, this.attributeId});

  factory Combinations.fromJson(Map<String, dynamic> json) =>
      _$CombinationsFromJson(json);

  Map<String, dynamic> toJson() => _$CombinationsToJson(this);

  @override
  List<Object?> get props => [valueId, attributeId];
}
