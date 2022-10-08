import 'package:json_annotation/json_annotation.dart';

part 'UserDataModel.g.dart';

@JsonSerializable()
class UserDataModel {
  String? email;
  String? name;
  String? bannerImage;
  String? profileImage;
  bool? isEmailVerified;
  int? cartCount;
  int? customerId;
  bool? isSeller;

  UserDataModel(
      {this.name,
      this.email,
      this.bannerImage,
      this.profileImage,
      this.isEmailVerified,
      this.cartCount,
        this.customerId, this.isSeller});

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

}
