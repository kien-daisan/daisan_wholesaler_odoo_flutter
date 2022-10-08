// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDetailModel _$AddressDetailModelFromJson(Map<String, dynamic> json) =>
    AddressDetailModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      name: json['name'] as String?,
      street: json['street'] as String?,
      zip: json['zip'] as String?,
      city: json['city'] as String?,
      stateId: json['state_id'],
      countryId: json['country_id'],
      phone: json['phone'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AddressDetailModelToJson(AddressDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'name': instance.name,
      'street': instance.street,
      'zip': instance.zip,
      'city': instance.city,
      'state_id': instance.stateId,
      'country_id': instance.countryId,
      'phone': instance.phone,
    };
