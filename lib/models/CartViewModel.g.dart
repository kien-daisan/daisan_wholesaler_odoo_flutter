// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartViewModel _$CartViewModelFromJson(Map<String, dynamic> json) =>
    CartViewModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      name: json['name'] as String?,
      subtotal: json['subtotal'] == null
          ? null
          : Subtotal.fromJson(json['subtotal'] as Map<String, dynamic>),
      tax: json['tax'] == null
          ? null
          : Subtotal.fromJson(json['tax'] as Map<String, dynamic>),
      grandtotal: json['grandtotal'] == null
          ? null
          : Subtotal.fromJson(json['grandtotal'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CartViewModelToJson(CartViewModel instance) =>
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
      'name': instance.name,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'grandtotal': instance.grandtotal,
      'items': instance.items,
    };

Subtotal _$SubtotalFromJson(Map<String, dynamic> json) => Subtotal(
      title: json['title'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$SubtotalToJson(Subtotal instance) => <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      lineId: json['lineId'] as int?,
      templateId: json['templateId'] as int?,
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      priceReduce: json['priceReduce'] as String?,
      priceUnit: json['priceUnit'] as String?,
      qty: (json['qty'] as num?)?.toDouble(),
      total: json['total'] as String?,
      discount: json['discount'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'lineId': instance.lineId,
      'templateId': instance.templateId,
      'name': instance.name,
      'thumbNail': instance.thumbNail,
      'priceReduce': instance.priceReduce,
      'priceUnit': instance.priceUnit,
      'qty': instance.qty,
      'total': instance.total,
      'discount': instance.discount,
    };
