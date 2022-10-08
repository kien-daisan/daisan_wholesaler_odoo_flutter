// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WishlistModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) =>
    WishlistModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      wishLists: (json['wishLists'] as List<dynamic>?)
          ?.map((e) => WishListItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
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
      'isEmailVerified': instance.isEmailVerified,
      'wishLists': instance.wishLists,
    };

WishListItems _$WishListItemsFromJson(Map<String, dynamic> json) =>
    WishListItems(
      id: json['id'] as int?,
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      priceReduce: json['priceReduce'] as String?,
      priceUnit: json['priceUnit'] as String?,
      productId: json['productId'] as int?,
      templateId: json['templateId'] as int?,
    );

Map<String, dynamic> _$WishListItemsToJson(WishListItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbNail': instance.thumbNail,
      'priceReduce': instance.priceReduce,
      'priceUnit': instance.priceUnit,
      'productId': instance.productId,
      'templateId': instance.templateId,
    };
