// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      userId: json['userId'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      cartCount: json['cartCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_state'] as String?,
      wishlistCount: json['wishlistCount'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      customerId: json['customerId'] as int?,
      notificationList: (json['all_notification_messages'] as List<dynamic>?)
          ?.map((e) => NotificationList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
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
      'all_notification_messages': instance.notificationList,
    };

NotificationList _$NotificationListFromJson(Map<String, dynamic> json) =>
    NotificationList(
      body: json['body'] as String?,
      name: json['name'] as String?,
      id: json['id'] as int?,
      icon: json['icon'] as String?,
      title: json['title'] as String?,
      banner: json['banner'] as String?,
      dataType: json['datatype'] as String?,
      isRead: json['is_reade'] as bool?,
      period: json['period'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$NotificationListToJson(NotificationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'body': instance.body,
      'banner': instance.banner,
      'icon': instance.icon,
      'period': instance.period,
      'datatype': instance.dataType,
      'is_reade': instance.isRead,
    };
