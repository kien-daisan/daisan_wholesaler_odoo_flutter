// ignore_for_file: file_names

import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SignUpScreenModel.g.dart';

@JsonSerializable()
class SignUpScreenModel extends BaseModel{
int? itemsPerPage;
Addons? addons;
int? userId;
int? customerId;
@JsonKey(name: "seller_message")
  String? sellerMessage;
Login? login;
@JsonKey(name: "cred")
Cred? credentials;
HomePage? homePage;

SignUpScreenModel({this.homePage, this.addons, this.login, this.itemsPerPage , this.customerId, this.credentials, this.sellerMessage, this.userId});
factory SignUpScreenModel.fromJson(Map<String, dynamic> json) =>
    _$SignUpScreenModelFromJson(json);

Map<String, dynamic> toJson() => _$SignUpScreenModelToJson(this);
}

@JsonSerializable()
class Login{
  bool? success;
  int? responseCode;
  String? message;
  int? customerId;
  int? userId;
  int? cartCount;
  @JsonKey(name:"WishlistCount")
  int? wishListCount;
  @JsonKey(name:"is_email_verified")
  bool? isEmailVerified;
  @JsonKey(name:"is_seller")
  bool? isSeller;
  String? customerBannerImage;
  String? customerProfileImage;
  String? cartId;
  String? themeCode;
  String? customerName;
  String? customerEmail;
  String? customerLang;

  Login({this.userId, this.customerId, this.success,this.message, this.customerName, this.customerEmail, this.cartCount, this.cartId, this.customerBannerImage, this.customerLang, this.customerProfileImage, this.isEmailVerified, this.responseCode, this.themeCode, this.wishListCount, this.isSeller});

  factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class Cred{
String? login;
@JsonKey(name:"pwd")
String? password;

Cred({this.login, this.password});

  factory Cred.fromJson(Map<String, dynamic> json) =>
      _$CredFromJson(json);

  Map<String, dynamic> toJson() => _$CredToJson(this);
}

@JsonSerializable()
class HomePage{
  List<String>? defaultLanguage;
  List<List<String>>? allLanguages;
  @JsonKey(name: "TermsAndConditions")
  bool? termsAndConditions;
  List<Categories>? categories;
  List<BannerImages>? bannerImages;
  List<FeaturedCategories>? featuredCategories;
  List<ProductSliders>? productSliders;

  HomePage({this.categories, this.allLanguages, this.bannerImages, this.defaultLanguage, this.featuredCategories, this.productSliders, this.termsAndConditions});

  factory HomePage.fromJson(Map<String, dynamic> json) =>
      _$HomePageFromJson(json);

  Map<String, dynamic> toJson() => _$HomePageToJson(this);

}
