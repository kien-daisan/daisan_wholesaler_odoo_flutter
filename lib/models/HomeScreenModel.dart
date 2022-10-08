import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HomeScreenModel.g.dart';


@JsonSerializable()
class HomePageData extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  List<String>? defaultLanguage;
  @JsonKey(name: "TermsAndConditions")
  bool? termsAndConditions;
  List<Categories>? categories;
  List<BannerImages>? bannerImages;
  List<FeaturedCategories>? featuredCategories;
  List<ProductSliders>? productSliders;



  HomePageData({
    this.addons,
    this.itemsPerPage,
    this.termsAndConditions,
    this.bannerImages,
    this.categories,
    this.defaultLanguage,
    this.featuredCategories,
    this.productSliders,
  });

  factory HomePageData.fromJson(Map<String, dynamic> json) =>
      _$HomePageDataFromJson(json);


}

@JsonSerializable()
class Addons{
  bool? wishlist;
  bool? review;
  @JsonKey(name: "email_verification")
  bool? emailVerification;
  @JsonKey(name: "odoo_marketplace")
  bool? odooMarketplace;
  @JsonKey(name: "website_sale_delivery")
  bool? websiteSaleDelivery;
  @JsonKey(name: "odoo_gdpr")
  bool? odooGdpr;
  @JsonKey(name: "website_sale_stock")
  bool? websiteSaleStock;

  Addons({this.wishlist,this.review,this.emailVerification,this.odooGdpr,this.odooMarketplace,this.websiteSaleDelivery,this.websiteSaleStock});

  factory Addons.fromJson(Map<String, dynamic> json) =>
      _$AddonsFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsToJson(this);
}

@JsonSerializable()
class Categories{
  @JsonKey(name: "category_id")
  int? categoryId;
  String? name;
  List<Categories>? children;
  String? icon;

  Categories({this.categoryId, this.name, this.children, this.icon});

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

}



@JsonSerializable()
class BannerImages{
  String? bannerName;
  String? bannerType;
  String? domain;
  dynamic id;
  String? url;

  BannerImages({this.bannerName, this.bannerType, this.id, this.url});

  factory BannerImages.fromJson(Map<String, dynamic> json) =>
      _$BannerImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BannerImagesToJson(this);

}

@JsonSerializable()
class FeaturedCategories{
  String? categoryName;
  int? categoryId;
  String? url;
  int? category_id;
  String? name;
  List<Children>? children;

  FeaturedCategories({this.categoryName, this.categoryId, this.url, this.category_id,this.name,this.children});

  factory FeaturedCategories.fromJson(Map<String, dynamic> json) =>
      _$FeaturedCategoriesFromJson(json);

}

@JsonSerializable()
class Children{
  @JsonKey(name: "category_id")
  int? categoryId;
  String? name;
  List<Children>? children;
  String? icon;

  Children({this.categoryId, this.name, this.children, this.icon});

  factory Children.fromJson(Map<String, dynamic> json) =>
      _$ChildrenFromJson(json);
  Map<String, dynamic> toJson() => _$ChildrenToJson(this);

}

@JsonSerializable()
class ProductSliders{
  String? title;
  @JsonKey(name: "item_display_limit")
  int? itemDisplayLimit;
  @JsonKey(name: "slider_mode")
  String? sliderMode;
  @JsonKey(name: "product_img_position")
  String? productImgPosition;
  List<Products>? products;
  String? url;

  ProductSliders({this.title, this.itemDisplayLimit, this.sliderMode, this.productImgPosition, this.products, this.url});

  factory ProductSliders.fromJson(Map<String, dynamic> json) =>
      _$ProductSlidersFromJson(json);

}

@JsonSerializable()
class Products{
  int? templateId;
  String? name;
  String? priceUnit;
  String? priceReduce;
  int? productId;
  int? productCount;
  String? description;
  String? thumbNail;

  Products({this.templateId, this.name, this.priceUnit, this.priceReduce, this.productId, this.productCount, this.description, this.thumbNail});

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

}
