// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      cartCount: json['cartCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      itemsPerPage: json['itemsPerPage'] as int?,
      recentOrders: (json['recentOrders'] as List<dynamic>?)
          ?.map((e) => RecentOrders.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_state'] as String?,
      tcount: json['tcount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
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
      'recentOrders': instance.recentOrders,
    };

RecentOrders _$RecentOrdersFromJson(Map<String, dynamic> json) => RecentOrders(
      url: json['url'] as String?,
      name: json['name'] as String?,
      id: json['id'] as int?,
      amountTotal: json['amount_total'] as String?,
      canReOrder: json['canReOrder'] as bool?,
      createDate: json['create_date'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      shippingAddressUrl: json['shipAdd_url'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$RecentOrdersToJson(RecentOrders instance) =>
    <String, dynamic>{
      'amount_total': instance.amountTotal,
      'canReOrder': instance.canReOrder,
      'create_date': instance.createDate,
      'id': instance.id,
      'name': instance.name,
      'shipAdd_url': instance.shippingAddressUrl,
      'shipping_address': instance.shippingAddress,
      'status': instance.status,
      'url': instance.url,
    };
