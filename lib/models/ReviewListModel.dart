import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ReviewListModel.g.dart';

@JsonSerializable()
class ReviewListModel extends BaseModel {
  int? itemsPerPage;
  @JsonKey(name: "product_reviews")
  List<ProductReviews>? productReviews;
  int? reviewCount;

  ReviewListModel({this.itemsPerPage, this.productReviews, this.reviewCount});

  factory ReviewListModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewListModelFromJson(json);

}

@JsonSerializable()
class ProductReviews {
  int? id;
  String? customer;
  @JsonKey(name: "customer_image")
  String? customerImage;
  String? email;
  int? likes;
  int? dislikes;
  double? rating;
  String? title;
  String? msg;
  @JsonKey(name: "create_date")
  String? createDate;
  @JsonKey(name: "write_date")
  String? writeDate;
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;

  ProductReviews(
      {this.id,
      this.customer,
      this.customerImage,
      this.email,
      this.likes,
      this.dislikes,
      this.rating,
      this.title,
      this.msg,
      this.createDate,
      this.writeDate,
      this.isEmailVerified});

  factory ProductReviews.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewsFromJson(json);

}
