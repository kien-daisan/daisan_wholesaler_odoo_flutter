import 'dart:convert';

import 'package:flutter_project_structure/models/AddressDetailModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class AddEditAddressRepository {
  Future<CountryListModel> getCountryList();

  Future<AddressDetailModel> getAddressDetails(String endPoint);

  Future<BaseModel> updateAddress(String endPoint, String name, String phone,
      String street, String city, String zip, String countryId, String stateId);

  Future<BaseModel> addNewAddress(String name, String phone, String street,
      String city, String zip, String countryId, String stateId);
}

class AddEditAddressRepositoryImp extends AddEditAddressRepository {
  @override
  Future<CountryListModel> getCountryList() async {
    CountryListModel model;
    model = await ApiClient().getCountryList();
    return model;
  }

  @override
  Future<AddressDetailModel> getAddressDetails(String endPoint) async {
    AddressDetailModel model;
    model = await ApiClient().getAddressDetails(endPoint);
    return model;
  }

  @override
  Future<BaseModel> updateAddress(
      String endPoint,
      String name,
      String phone,
      String street,
      String city,
      String zip,
      String countryId,
      String stateId) async {
    BaseModel model;
    Map<String, dynamic> data = {};
    data["name"] = name;
    data["phone"] = phone;
    data["street"] = street;
    data["city"] = city;
    // data["zip"] = '';
    data["country_id"] = countryId;
    if(stateId != "null")data["state_id"] = stateId;
    String body = json.encode(data);
    model = await ApiClient().updateAddress(endPoint, body);
    return model;
  }

  @override
  Future<BaseModel> addNewAddress(String name, String phone, String street,
      String city, String zip, String countryId, String stateId) async {
    BaseModel model;
    Map<String, dynamic> data = {};
    data["name"] = name;
    data["phone"] = phone;
    data["street"] = street;
    data["city"] = city;
    // data["zip"] = zip;
    data["country_id"] = countryId;
    if(stateId != "null")data["state_id"] = stateId;
    String body = json.encode(data);
    model = await ApiClient().addNewAddress(body);
    return model;
  }
}
