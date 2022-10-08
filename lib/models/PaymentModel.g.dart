// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      acquirers: (json['acquirers'] as List<dynamic>?)
          ?.map((e) => Acquirers.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
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
      'acquirers': instance.acquirers,
    };

Acquirers _$AcquirersFromJson(Map<String, dynamic> json) => Acquirers(
      id: json['id'] as int?,
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      extraKey: json['extraKey'] as String?,
    );

Map<String, dynamic> _$AcquirersToJson(Acquirers instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbNail': instance.thumbNail,
      'description': instance.description,
      'code': instance.code,
      'extraKey': instance.extraKey,
    };
