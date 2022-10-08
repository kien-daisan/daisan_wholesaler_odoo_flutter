// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressListModel _$AddressListModelFromJson(Map<String, dynamic> json) =>
    AddressListModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      tcount: json['tcount'] as int?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Addresses.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultShippingAddressId: json['default_shipping_address_id'] == null
          ? null
          : Addresses.fromJson(
              json['default_shipping_address_id'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AddressListModelToJson(AddressListModel instance) =>
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
      'tcount': instance.tcount,
      'addresses': instance.addresses,
      'default_shipping_address_id': instance.defaultShippingAddressId,
    };

Addresses _$AddressesFromJson(Map<String, dynamic> json) => Addresses(
      name: json['name'] as String?,
      url: json['url'] as String?,
      addressId: json['addressId'] as int?,
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$AddressesToJson(Addresses instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'addressId': instance.addressId,
      'display_name': instance.displayName,
    };
