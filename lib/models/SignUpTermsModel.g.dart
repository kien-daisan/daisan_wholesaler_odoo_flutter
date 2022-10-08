// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpTermsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpTermsModel _$SignUpTermsModelFromJson(Map<String, dynamic> json) =>
    SignUpTermsModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      termsAndConditions: json['termsAndConditions'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?
      ..sellerTermsAndConditions = json['term_and_condition'] as String?;

Map<String, dynamic> _$SignUpTermsModelToJson(SignUpTermsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'termsAndConditions': instance.termsAndConditions,
      'term_and_condition': instance.sellerTermsAndConditions,
    };
