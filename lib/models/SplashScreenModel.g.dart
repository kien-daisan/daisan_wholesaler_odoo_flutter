// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SplashScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashScreenModel _$SplashScreenModelFromJson(Map<String, dynamic> json) =>
    SplashScreenModel(
      itemsPerPage: json['itemsPerPage'] as int?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      allowResetPwd: json['allow_resetPwd'] as bool?,
      allowSignup: json['allow_signup'] as bool?,
      allowGuestCheckout: json['allow_guestCheckout'] as bool?,
      allowGmailSign: json['allow_gmailSign'] as bool?,
      allowFacebookSign: json['allow_facebookSign'] as bool?,
      allowTwitterSign: json['allow_twitterSign'] as bool?,
      allowShipping: json['allowShipping'] as bool?,
      privacyPolicyUrl: json['privacy_policy_url'],
      allLanguages: (json['allLanguages'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      defaultLanguage: (json['defaultLanguage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      termsAndConditions: json['termsAndConditions'] as bool?,
      ratingStatus: (json['ratingStatus'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      sortData: (json['sortData'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SplashScreenModelToJson(SplashScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'allow_resetPwd': instance.allowResetPwd,
      'allow_signup': instance.allowSignup,
      'allow_guestCheckout': instance.allowGuestCheckout,
      'allow_gmailSign': instance.allowGmailSign,
      'allow_facebookSign': instance.allowFacebookSign,
      'allow_twitterSign': instance.allowTwitterSign,
      'allowShipping': instance.allowShipping,
      'privacy_policy_url': instance.privacyPolicyUrl,
      'sortData': instance.sortData,
      'defaultLanguage': instance.defaultLanguage,
      'allLanguages': instance.allLanguages,
      'termsAndConditions': instance.termsAndConditions,
      'ratingStatus': instance.ratingStatus,
    };
