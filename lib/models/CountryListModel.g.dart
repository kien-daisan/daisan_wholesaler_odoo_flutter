// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CountryListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListModel _$CountryListModelFromJson(Map<String, dynamic> json) =>
    CountryListModel(
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Countries.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = json['responseCode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CountryListModelToJson(CountryListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'countries': instance.countries,
    };

Countries _$CountriesFromJson(Map<String, dynamic> json) => Countries(
      id: json['id'] as int?,
      name: json['name'] as String?,
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => States.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'states': instance.states,
    };

States _$StatesFromJson(Map<String, dynamic> json) => States(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StatesToJson(States instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
