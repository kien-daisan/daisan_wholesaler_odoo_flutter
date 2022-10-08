// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderReviewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReviewModel _$OrderReviewModelFromJson(Map<String, dynamic> json) =>
    OrderReviewModel(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: json['customerId'] as int?,
      userId: json['userId'] as int?,
      cartCount: json['cartCount'] as int?,
      wishlistCount: json['wishlistCount'] as int?,
      isEmailVerified: json['is_email_verified'] as bool?,
      paymentTerms: json['paymentTerms'] == null
          ? null
          : PaymentTerms.fromJson(json['paymentTerms'] as Map<String, dynamic>),
      name: json['name'] as String?,
      billingAddress: json['billingAddress'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      paymentAcquirer: json['paymentAcquirer'] as String?,
      subtotal: json['subtotal'] == null
          ? null
          : Subtotal.fromJson(json['subtotal'] as Map<String, dynamic>),
      tax: json['tax'] == null
          ? null
          : Subtotal.fromJson(json['tax'] as Map<String, dynamic>),
      grandtotal: json['grandtotal'] == null
          ? null
          : Subtotal.fromJson(json['grandtotal'] as Map<String, dynamic>),
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      delivery: json['delivery'] == null
          ? null
          : Delivery.fromJson(json['delivery'] as Map<String, dynamic>),
      paymentData: json['paymentData'] == null
          ? null
          : PaymentData.fromJson(json['paymentData'] as Map<String, dynamic>),
      transactionId: json['transaction_id'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$OrderReviewModelToJson(OrderReviewModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'paymentTerms': instance.paymentTerms,
      'name': instance.name,
      'billingAddress': instance.billingAddress,
      'shippingAddress': instance.shippingAddress,
      'paymentAcquirer': instance.paymentAcquirer,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'grandtotal': instance.grandtotal,
      'amount': instance.amount,
      'currency': instance.currency,
      'items': instance.items,
      'delivery': instance.delivery,
      'paymentData': instance.paymentData,
      'transaction_id': instance.transactionId,
    };

PaymentTerms _$PaymentTermsFromJson(Map<String, dynamic> json) => PaymentTerms(
      paymentShortTerms: json['paymentShortTerms'] as String?,
      paymentLongTerms: json['paymentLongTerms'] as String?,
    );

Map<String, dynamic> _$PaymentTermsToJson(PaymentTerms instance) =>
    <String, dynamic>{
      'paymentShortTerms': instance.paymentShortTerms,
      'paymentLongTerms': instance.paymentLongTerms,
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

Delivery _$DeliveryFromJson(Map<String, dynamic> json) => Delivery(
      tax: (json['tax'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      shippingId: json['shippingId'] as int?,
      total: json['total'] as String?,
    );

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'tax': instance.tax,
      'name': instance.name,
      'description': instance.description,
      'shippingId': instance.shippingId,
      'total': instance.total,
    };

PaymentData _$PaymentDataFromJson(Map<String, dynamic> json) => PaymentData(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      auth: json['auth'] as bool?,
      customerEmail: json['customer_email'] as String?,
    );

Map<String, dynamic> _$PaymentDataToJson(PaymentData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'auth': instance.auth,
      'customer_email': instance.customerEmail,
    };
