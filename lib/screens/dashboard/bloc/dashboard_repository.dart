import 'dart:convert';

import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class DashboardRepository{
  Future<OrderModel> getOrderList(int offset, int limit);
  Future<AddressListModel> getAddressList();
  Future<BaseModel> saveDefaultShipping(String addressId);
  Future<AccountInfoModel> setImage(String image,String type);
  Future<BaseModel> deleteImage();
}

class DashboardRepositoryImp implements DashboardRepository{

  @override
  Future<OrderModel> getOrderList(int offset, int limit) async{
    OrderModel? model;
    Map<String,dynamic> data = {};
    data["offset"] = offset;
    data["limit"] = limit;
    String body = json.encode(data);
    model = await ApiClient().getOrderList(body);
    return model;
  }

  @override
  Future<AddressListModel> getAddressList() async {
    AddressListModel model;
    model = await ApiClient().getAddressList();
    return model;
  }
  @override
  Future<BaseModel> saveDefaultShipping(String addressId) async {
    BaseModel model;
    model = await ApiClient().saveDefaultShippingAddress(addressId);
    return model;
  }

  @override
  Future<AccountInfoModel> setImage(String image,String type) async{
    AccountInfoModel? model;
    Map<String,dynamic> data = {};
    data[type] = image;
    String body = json.encode(data);
    model = await ApiClient().saveAccountInfo(body);
    return model;
  }

  @override
  Future<BaseModel> deleteImage() async{
    BaseModel? baseModel;
    baseModel = await ApiClient().deleteProfileImage();
    return baseModel;
  }
}