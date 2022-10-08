// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchScreenModel _$SearchScreenModelFromJson(Map<String, dynamic> json) =>
    SearchScreenModel(
      isEmailVerified: json['is_email_verified'] as bool?,
      customerId: json['customerId'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      sellerState: json['seller_state'] as String?,
      sellerGroup: json['seller_group'] as String?,
      isSeller: json['is_seller'] as bool?,
      cartCount: json['cartCount'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
      offset: json['offset'] as int?,
      tcount: json['tcount'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SearchScreenModelToJson(SearchScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'tcount': instance.tcount,
      'offset': instance.offset,
      'products': instance.products,
    };
