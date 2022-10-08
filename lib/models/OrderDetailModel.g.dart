// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['WishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_tate'] as String?,
      name: json['name'] as String?,
      createDate: json['create_date'] as String?,
      amountTotal: json['amount_total'] as String?,
      status: json['status'] as String?,
      amountUntaxed: json['amount_untaxed'] as String?,
      amountTax: json['amount_tax'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      shipAddUrl: json['shipAdd_url'] as String?,
      billingAddress: json['billing_address'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      delivery: json['delivery'] == null
          ? null
          : Delivery.fromJson(json['delivery'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_tate': instance.sellerState,
      'name': instance.name,
      'create_date': instance.createDate,
      'amount_total': instance.amountTotal,
      'status': instance.status,
      'amount_untaxed': instance.amountUntaxed,
      'amount_tax': instance.amountTax,
      'shipping_address': instance.shippingAddress,
      'shipAdd_url': instance.shipAddUrl,
      'billing_address': instance.billingAddress,
      'items': instance.items,
      'delivery': instance.delivery,
    };

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
      name: json['name'] as String?,
      productName: json['product_name'] as String?,
      qty: json['qty'] as String?,
      priceUnit: json['price_unit'] as String?,
      priceSubtotal: json['price_subtotal'] as String?,
      priceTax: json['price_tax'] as String?,
      priceTotal: json['price_total'] as String?,
      discount: json['discount'] as String?,
      state: json['state'] as String?,
      thumbNail: json['thumbNail'] as String?,
      templateId: json['templateId'] as int?,
    );

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product_name': instance.productName,
      'qty': instance.qty,
      'price_unit': instance.priceUnit,
      'price_subtotal': instance.priceSubtotal,
      'price_tax': instance.priceTax,
      'price_total': instance.priceTotal,
      'discount': instance.discount,
      'state': instance.state,
      'thumbNail': instance.thumbNail,
      'templateId': instance.templateId,
    };
