import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'HomeScreenModel.dart';

part 'CategoryScreenModel.g.dart';

@JsonSerializable()
class CategoryScreenModel extends BaseModel{
  int? itemsPerPage;
  Addons? addons;
  int? offset;
  int? tcount;
  List<Products>? products;

  CategoryScreenModel(
      {
        this.itemsPerPage,
        this.addons,
        this.offset,
        this.tcount,
        this.products});

  factory CategoryScreenModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryScreenModelFromJson(json);
}



