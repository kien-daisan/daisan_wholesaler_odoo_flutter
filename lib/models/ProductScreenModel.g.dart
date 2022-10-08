// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductScreenModel _$ProductScreenModelFromJson(Map<String, dynamic> json) =>
    ProductScreenModel(
      json['templateId'] as int?,
      json['name'] as String?,
      (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['thumbNail'] as String?,
      json['absoluteUrl'] as String?,
      json['addedToWishlist'] as bool?,
      json['add_to_cart'] as bool?,
      (json['alternativeProducts'] as List<dynamic>?)
          ?.map((e) => AlternativeProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ar_android'] as String?,
      json['ar_ios'] as String?,
      (json['avg_rating'] as num?)?.toDouble(),
      json['description'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['itemsPerPage'] as int?,
      json['priceReduce'] as String?,
      json['priceUnit'] as String?,
      json['productCount'] as int?,
      json['productId'] as int?,
      json['stock_display_msg'] as String?,
      json['total_review'] as int?,
      (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductScreenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['product_sku'] as String?,
      (json['combinations'] as List<dynamic>?)
          ?.map((e) => Combinations.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..addons = json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>);

Map<String, dynamic> _$ProductScreenModelToJson(ProductScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'templateId': instance.templateId,
      'name': instance.name,
      'images': instance.images,
      'avg_rating': instance.avgRating,
      'total_review': instance.totalReview,
      'priceUnit': instance.priceUnit,
      'priceReduce': instance.priceReduce,
      'productId': instance.productId,
      'productCount': instance.productCount,
      'description': instance.description,
      'alternativeProducts': instance.alternativeProducts,
      'ar_ios': instance.arIos,
      'ar_android': instance.arAndroid,
      'thumbNail': instance.thumbNail,
      'absoluteUrl': instance.absoluteUrl,
      'addedToWishlist': instance.addedToWishlist,
      'add_to_cart': instance.addToCart,
      'stock_display_msg': instance.stockDisplayMsg,
      'product_sku': instance.productSku,
      'attributes': instance.attributes,
      'variants': instance.variants,
      'combinations': instance.combinations,
    };

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      name: json['name'] as String?,
      type: json['type'] as String?,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => Values.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeId: json['attributeId'] as int?,
      newVariant: json['newVariant'] as String?,
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'attributeId': instance.attributeId,
      'name': instance.name,
      'newVariant': instance.newVariant,
      'type': instance.type,
      'values': instance.values,
    };

Values _$ValuesFromJson(Map<String, dynamic> json) => Values(
      newVariant: json['newVariant'] as String?,
      name: json['name'] as String?,
      htmlCode: json['htmlCode'] as String?,
      valueId: json['valueId'] as int?,
    )..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$ValuesToJson(Values instance) => <String, dynamic>{
      'name': instance.name,
      'valueId': instance.valueId,
      'htmlCode': instance.htmlCode,
      'newVariant': instance.newVariant,
      'isSelected': instance.isSelected,
    };

AlternativeProducts _$AlternativeProductsFromJson(Map<String, dynamic> json) =>
    AlternativeProducts(
      json['name'] as String?,
      json['image'] as String?,
      json['templateId'] as int?,
    );

Map<String, dynamic> _$AlternativeProductsToJson(
        AlternativeProducts instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'name': instance.name,
      'image': instance.image,
    };

Variants _$VariantsFromJson(Map<String, dynamic> json) => Variants(
      productId: json['productId'] as int?,
      priceReduce: json['priceReduce'] as String?,
      stockDisplayMsg: json['stock_display_msg'] as String?,
      priceUnit: json['priceUnit'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      arIos: json['ar_ios'] as String?,
      arAndroid: json['ar_ android'] as String?,
      addToCart: json['add_to_cart'] as bool?,
      absoluteUrl: json['absoluteUrl'] as String?,
      addedToWishlist: json['addedToWishlist'] as bool?,
      combinations: (json['combinations'] as List<dynamic>?)
          ?.map((e) => Combinations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantsToJson(Variants instance) => <String, dynamic>{
      'productId': instance.productId,
      'images': instance.images,
      'ar_ios': instance.arIos,
      'ar_ android': instance.arAndroid,
      'absoluteUrl': instance.absoluteUrl,
      'priceReduce': instance.priceReduce,
      'priceUnit': instance.priceUnit,
      'combinations': instance.combinations,
      'addedToWishlist': instance.addedToWishlist,
      'add_to_cart': instance.addToCart,
      'stock_display_msg': instance.stockDisplayMsg,
    };

Combinations _$CombinationsFromJson(Map<String, dynamic> json) => Combinations(
      valueId: json['valueId'] as int?,
      attributeId: json['attributeId'] as int?,
    );

Map<String, dynamic> _$CombinationsToJson(Combinations instance) =>
    <String, dynamic>{
      'valueId': instance.valueId,
      'attributeId': instance.attributeId,
    };
