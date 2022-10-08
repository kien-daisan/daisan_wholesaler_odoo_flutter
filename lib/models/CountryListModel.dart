import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CountryListModel.g.dart';

@JsonSerializable()
class CountryListModel extends BaseModel {
  List<Countries>? countries;
  CountryListModel({this.countries});
  
  factory CountryListModel.fromJson(Map<String, dynamic> json) =>
      _$CountryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryListModelToJson(this);
}

@JsonSerializable()
class Countries {
  int? id;
  String? name;
  List<States>? states;

  Countries({this.id, this.name, this.states});

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}

@JsonSerializable()
class States {
  int? id;
  String? name;

  States({this.id, this.name});

  factory States.fromJson(Map<String, dynamic> json) =>
      _$StatesFromJson(json);

  Map<String, dynamic> toJson() => _$StatesToJson(this);
}
