// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoModel _$AccountInfoModelFromJson(Map<String, dynamic> json) =>
    AccountInfoModel(
      wishlistCount: json['WishlistCount'] as int?,
      sellerState: json['seller_state'] as String?,
      downloadRequest: json['downloadRequest'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      isSeller: json['is_seller'] as bool?,
      isEmailVerified: json['is_email_verified'] as bool?,
      cartCount: json['cartCount'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      downloadMessage: json['downloadMessage'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      customerBannerImage: json['customerBannerImage'] as String?,
      customerProfileImage: json['customerProfileImage'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AccountInfoModelToJson(AccountInfoModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'downloadRequest': instance.downloadRequest,
      'downloadMessage': instance.downloadMessage,
      'downloadUrl': instance.downloadUrl,
      'customerBannerImage': instance.customerBannerImage,
      'customerProfileImage': instance.customerProfileImage,
    };
