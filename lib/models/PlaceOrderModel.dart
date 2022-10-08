import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'HomeScreenModel.dart';
part 'PlaceOrderModel.g.dart';

@JsonSerializable()
class PlaceOrderModel extends BaseModel{
  Addons? addons;
  String? name;
  String? txn_msg;

  PlaceOrderModel({this.addons,this.name,this.txn_msg});

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderModelFromJson(json);
}