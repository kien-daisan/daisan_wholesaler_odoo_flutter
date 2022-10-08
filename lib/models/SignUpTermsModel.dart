import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SignUpTermsModel.g.dart';

@JsonSerializable()
class SignUpTermsModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
 String? termsAndConditions;
 @JsonKey(name:"term_and_condition" )
 String? sellerTermsAndConditions;
 SignUpTermsModel({this.itemsPerPage, this.addons, this.termsAndConditions});
  factory SignUpTermsModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpTermsModelToJson(this);
}