// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      bannerImage: json['bannerImage'] as String?,
      profileImage: json['profileImage'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      cartCount: json['cartCount'] as int?,
      customerId: json['customerId'] as int?,
      isSeller: json['isSeller'] as bool?,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'bannerImage': instance.bannerImage,
      'profileImage': instance.profileImage,
      'isEmailVerified': instance.isEmailVerified,
      'cartCount': instance.cartCount,
      'customerId': instance.customerId,
      'isSeller': instance.isSeller,
    };
