// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      wishListCount: json['WishlistCount'] as int?,
      themeCode: json['themeCode'] as String?,
      isEmailVerified: json['is_email_verified'] as bool?,
      customerProfileImage: json['customerProfileImage'] as String?,
      customerLang: json['customerLang'] as String?,
      customerBannerImage: json['customerBannerImage'] as String?,
      cartId: json['cartId'],
      cartCount: json['cartCount'] as int?,
      customerEmail: json['customerEmail'] as String?,
      customerName: json['customerName'] as String?,
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      itemPerPage: json['itemPerPage'] as int?,
      isSeller: json['is_seller'] as bool?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemPerPage': instance.itemPerPage,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishListCount,
      'is_email_verified': instance.isEmailVerified,
      'customerBannerImage': instance.customerBannerImage,
      'customerProfileImage': instance.customerProfileImage,
      'cartId': instance.cartId,
      'themeCode': instance.themeCode,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerLang': instance.customerLang,
      'is_seller': instance.isSeller,
    };
