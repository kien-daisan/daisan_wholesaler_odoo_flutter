// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryScreenModel _$CategoryScreenModelFromJson(Map<String, dynamic> json) =>
    CategoryScreenModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      offset: json['offset'] as int?,
      tcount: json['tcount'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CategoryScreenModelToJson(
        CategoryScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'offset': instance.offset,
      'tcount': instance.tcount,
      'products': instance.products,
    };
