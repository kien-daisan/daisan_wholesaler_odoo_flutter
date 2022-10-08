// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageData _$HomePageDataFromJson(Map<String, dynamic> json) => HomePageData(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      itemsPerPage: json['itemsPerPage'] as int?,
      termsAndConditions: json['TermsAndConditions'] as bool?,
      bannerImages: (json['bannerImages'] as List<dynamic>?)
          ?.map((e) => BannerImages.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
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
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$HomePageDataToJson(HomePageData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'defaultLanguage': instance.defaultLanguage,
      'TermsAndConditions': instance.termsAndConditions,
      'categories': instance.categories,
      'bannerImages': instance.bannerImages,
      'featuredCategories': instance.featuredCategories,
      'productSliders': instance.productSliders,
    };

Addons _$AddonsFromJson(Map<String, dynamic> json) => Addons(
      wishlist: json['wishlist'] as bool?,
      review: json['review'] as bool?,
      emailVerification: json['email_verification'] as bool?,
      odooGdpr: json['odoo_gdpr'] as bool?,
      odooMarketplace: json['odoo_marketplace'] as bool?,
      websiteSaleDelivery: json['website_sale_delivery'] as bool?,
      websiteSaleStock: json['website_sale_stock'] as bool?,
    );

Map<String, dynamic> _$AddonsToJson(Addons instance) => <String, dynamic>{
      'wishlist': instance.wishlist,
      'review': instance.review,
      'email_verification': instance.emailVerification,
      'odoo_marketplace': instance.odooMarketplace,
      'website_sale_delivery': instance.websiteSaleDelivery,
      'odoo_gdpr': instance.odooGdpr,
      'website_sale_stock': instance.websiteSaleStock,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      categoryId: json['category_id'] as int?,
      name: json['name'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'children': instance.children,
      'icon': instance.icon,
    };

BannerImages _$BannerImagesFromJson(Map<String, dynamic> json) => BannerImages(
      bannerName: json['bannerName'] as String?,
      bannerType: json['bannerType'] as String?,
      id: json['id'],
      url: json['url'] as String?,
    )..domain = json['domain'] as String?;

Map<String, dynamic> _$BannerImagesToJson(BannerImages instance) =>
    <String, dynamic>{
      'bannerName': instance.bannerName,
      'bannerType': instance.bannerType,
      'domain': instance.domain,
      'id': instance.id,
      'url': instance.url,
    };

FeaturedCategories _$FeaturedCategoriesFromJson(Map<String, dynamic> json) =>
    FeaturedCategories(
      categoryName: json['categoryName'] as String?,
      categoryId: json['categoryId'] as int?,
      url: json['url'] as String?,
      category_id: json['category_id'] as int?,
      name: json['name'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeaturedCategoriesToJson(FeaturedCategories instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
      'url': instance.url,
      'category_id': instance.category_id,
      'name': instance.name,
      'children': instance.children,
    };

Children _$ChildrenFromJson(Map<String, dynamic> json) => Children(
      categoryId: json['category_id'] as int?,
      name: json['name'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$ChildrenToJson(Children instance) => <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'children': instance.children,
      'icon': instance.icon,
    };

ProductSliders _$ProductSlidersFromJson(Map<String, dynamic> json) =>
    ProductSliders(
      title: json['title'] as String?,
      itemDisplayLimit: json['item_display_limit'] as int?,
      sliderMode: json['slider_mode'] as String?,
      productImgPosition: json['product_img_position'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ProductSlidersToJson(ProductSliders instance) =>
    <String, dynamic>{
      'title': instance.title,
      'item_display_limit': instance.itemDisplayLimit,
      'slider_mode': instance.sliderMode,
      'product_img_position': instance.productImgPosition,
      'products': instance.products,
      'url': instance.url,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      templateId: json['templateId'] as int?,
      name: json['name'] as String?,
      priceUnit: json['priceUnit'] as String?,
      priceReduce: json['priceReduce'] as String?,
      productId: json['productId'] as int?,
      productCount: json['productCount'] as int?,
      description: json['description'] as String?,
      thumbNail: json['thumbNail'] as String?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'templateId': instance.templateId,
      'name': instance.name,
      'priceUnit': instance.priceUnit,
      'priceReduce': instance.priceReduce,
      'productId': instance.productId,
      'productCount': instance.productCount,
      'description': instance.description,
      'thumbNail': instance.thumbNail,
    };
