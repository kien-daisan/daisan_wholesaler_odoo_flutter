import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HomeScreenModel.dart';

part 'SplashScreenModel.g.dart';

@JsonSerializable()
class SplashScreenModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  @JsonKey(name: "allow_resetPwd")
  bool? allowResetPwd;
  @JsonKey(name: "allow_signup")
  bool? allowSignup;
  @JsonKey(name: "allow_guestCheckout")
  bool? allowGuestCheckout;
  @JsonKey(name: "allow_gmailSign")
  bool? allowGmailSign;
  @JsonKey(name: "allow_facebookSign")
  bool? allowFacebookSign;
  @JsonKey(name: "allow_twitterSign")
  bool? allowTwitterSign;
  bool? allowShipping;
  @JsonKey(name: "privacy_policy_url")
  dynamic privacyPolicyUrl;
  List<List<String>>? sortData;
  List<String>? defaultLanguage;
  List<List<String>>? allLanguages;
  bool? termsAndConditions;
  List<List<String>>? ratingStatus;

  SplashScreenModel({this.itemsPerPage,this.addons,this.allowResetPwd,this.allowSignup,this.allowGuestCheckout,
    this.allowGmailSign,this.allowFacebookSign,this.allowTwitterSign,this.allowShipping,this.privacyPolicyUrl,this.allLanguages,
    this.defaultLanguage,this.termsAndConditions,this.ratingStatus,this.sortData});

  factory SplashScreenModel.fromJson(Map<String, dynamic> json) =>
      _$SplashScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SplashScreenModelToJson(this);
}


