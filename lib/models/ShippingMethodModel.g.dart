// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShippingMethodModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingMethodModel _$ShippingMethodModelFromJson(Map<String, dynamic> json) =>
    ShippingMethodModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['WishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      shippingMethods: (json['ShippingMethods'] as List<dynamic>?)
          ?.map((e) => ShippingMethods.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ShippingMethodModelToJson(
        ShippingMethodModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'ShippingMethods': instance.shippingMethods,
    };

ShippingMethods _$ShippingMethodsFromJson(Map<String, dynamic> json) =>
    ShippingMethods(
      name: json['name'] as String?,
      id: json['id'] as int?,
      description: json['description'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$ShippingMethodsToJson(ShippingMethods instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'price': instance.price,
    };
