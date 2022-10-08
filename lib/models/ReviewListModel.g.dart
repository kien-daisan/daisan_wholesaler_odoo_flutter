// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewListModel _$ReviewListModelFromJson(Map<String, dynamic> json) =>
    ReviewListModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      productReviews: (json['product_reviews'] as List<dynamic>?)
          ?.map((e) => ProductReviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewCount: json['reviewCount'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ReviewListModelToJson(ReviewListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'product_reviews': instance.productReviews,
      'reviewCount': instance.reviewCount,
    };

ProductReviews _$ProductReviewsFromJson(Map<String, dynamic> json) =>
    ProductReviews(
      id: json['id'] as int?,
      customer: json['customer'] as String?,
      customerImage: json['customer_image'] as String?,
      email: json['email'] as String?,
      likes: json['likes'] as int?,
      dislikes: json['dislikes'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      title: json['title'] as String?,
      msg: json['msg'] as String?,
      createDate: json['create_date'] as String?,
      writeDate: json['write_date'] as String?,
      isEmailVerified: json['is_email_verified'] as bool?,
    );

Map<String, dynamic> _$ProductReviewsToJson(ProductReviews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'customer_image': instance.customerImage,
      'email': instance.email,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'rating': instance.rating,
      'title': instance.title,
      'msg': instance.msg,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
      'is_email_verified': instance.isEmailVerified,
    };
