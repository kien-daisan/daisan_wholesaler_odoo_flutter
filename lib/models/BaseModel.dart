import 'package:json_annotation/json_annotation.dart';

part 'BaseModel.g.dart';


@JsonSerializable()
class BaseModel{
  bool? success;
  int? responseCode;
  String? message;

  BaseModel({this.success,this.responseCode,this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}