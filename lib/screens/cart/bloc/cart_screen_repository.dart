import 'dart:convert';

import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class CartScreenRepository{
  Future<CartViewModel> getCartData();
  Future<BaseModel> removeCartItem(int lineId);
  Future<BaseModel> cartToWishlist(String productName, int lineId);
  Future<BaseModel> setCartEmpty();
  Future<BaseModel> setCartItemQty(int lineId, int qty);
}

class CartScreenRepositoryImp extends CartScreenRepository{
  @override
  Future<CartViewModel> getCartData() async{
    CartViewModel model;
    model = await ApiClient().getCartData();
    return model;
  }

  @override
  Future<BaseModel> removeCartItem(int lineId) async{
    BaseModel? model;
    model = await ApiClient().removeCartItem(lineId);
    return model;
  }

  @override
  Future<BaseModel> cartToWishlist(String productName, int lineId) async{
    BaseModel? model;
    Map<String,dynamic> data = {};
    data["productName"] = productName;
    data["line_id"] = lineId;

    String body = json.encode(data);
    model = await ApiClient().cartToWishlist(body, "text/plain");
    return model;
  }

  @override
  Future<BaseModel> setCartEmpty() async{
    BaseModel? model;
    model = await ApiClient().setCartEmpty();
    return model;
  }

  @override
  Future<BaseModel> setCartItemQty(int lineId, int qty) async{
    BaseModel? baseModel;
    Map<String, dynamic> data = {};
    data['set_qty'] = qty;
    String body = json.encode(data);
    baseModel = await ApiClient().setCartItemQuantity(lineId, body);
    return baseModel;
  }

}