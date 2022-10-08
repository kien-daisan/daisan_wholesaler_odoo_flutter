// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpScreenModel _$SignUpScreenModelFromJson(Map<String, dynamic> json) =>
    SignUpScreenModel(
      homePage: json['homePage'] == null
          ? null
          : HomePage.fromJson(json['homePage'] as Map<String, dynamic>),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      login: json['login'] == null
          ? null
          : Login.fromJson(json['login'] as Map<String, dynamic>),
      itemsPerPage: json['itemsPerPage'] as int?,
      customerId: json['customerId'] as int?,
      credentials: json['cred'] == null
          ? null
          : Cred.fromJson(json['cred'] as Map<String, dynamic>),
      sellerMessage: json['seller_message'] as String?,
      userId: json['userId'] as int?,
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SignUpScreenModelToJson(SignUpScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'userId': instance.userId,
      'customerId': instance.customerId,
      'seller_message': instance.sellerMessage,
      'login': instance.login,
      'cred': instance.credentials,
      'homePage': instance.homePage,
    };

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      userId: json['userId'] as int?,
      customerId: json['customerId'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      cartCount: json['cartCount'] as int?,
      cartId: json['cartId'] as String?,
      customerBannerImage: json['customerBannerImage'] as String?,
      customerLang: json['customerLang'] as String?,
      customerProfileImage: json['customerProfileImage'] as String?,
      isEmailVerified: json['is_email_verified'] as bool?,
      responseCode: json['responseCode'] as int?,
      themeCode: json['themeCode'] as String?,
      wishListCount: json['WishlistCount'] as int?,
      isSeller: json['is_seller'] as bool?,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishListCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'customerBannerImage': instance.customerBannerImage,
      'customerProfileImage': instance.customerProfileImage,
      'cartId': instance.cartId,
      'themeCode': instance.themeCode,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerLang': instance.customerLang,
    };

Cred _$CredFromJson(Map<String, dynamic> json) => Cred(
      login: json['login'] as String?,
      password: json['pwd'] as String?,
    );

Map<String, dynamic> _$CredToJson(Cred instance) => <String, dynamic>{
      'login': instance.login,
      'pwd': instance.password,
    };

HomePage _$HomePageFromJson(Map<String, dynamic> json) => HomePage(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      allLanguages: (json['allLanguages'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      bannerImages: (json['bannerImages'] as List<dynamic>?)
          ?.map((e) => BannerImages.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultLanguage: (json['defaultLanguage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      featuredCategories: (json['featuredCategories'] as List<dynamic>?)
          ?.map((e) => FeaturedCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      productSliders: (json['productSliders'] as List<dynamic>?)
          ?.map((e) => ProductSliders.fromJson(e as Map<String, dynamic>))
          .toList(),
      termsAndConditions: json['TermsAndConditions'] as bool?,
    );

Map<String, dynamic> _$HomePageToJson(HomePage instance) => <String, dynamic>{
      'defaultLanguage': instance.defaultLanguage,
      'allLanguages': instance.allLanguages,
      'TermsAndConditions': instance.termsAndConditions,
      'categories': instance.categories,
      'bannerImages': instance.bannerImages,
      'featuredCategories': instance.featuredCategories,
      'productSliders': instance.productSliders,
    };
