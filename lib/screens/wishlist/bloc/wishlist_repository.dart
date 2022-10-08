import 'dart:convert';

import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/WishlistModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class WishlistRepository{
  Future<WishlistModel> getWishlistItems();
  Future<BaseModel> moveToCart(String productName, int wishlistId, int productId);
  Future<BaseModel> removeFromWishlist(int wishlistId);
}

class WishlistImpRepository implements WishlistRepository{
  @override
  Future<WishlistModel> getWishlistItems() async{
    WishlistModel? model;
    model = await ApiClient().getWishlistItems();
    return model;
  }

  @override
  Future<BaseModel> moveToCart(String productName, int wishlistId, int productId) async{
    BaseModel? model;
    Map<String, dynamic> data = {};
    data['productName'] = productName;
    data['wishlistId'] = wishlistId;
    data['productId'] = productId;
    String body = json.encode(data);
    model = await ApiClient().moveWishlistToCart(body);

    return model;
  }

  @override
  Future<BaseModel> removeFromWishlist(int wishlistId) async{
    BaseModel? model;
    model = await ApiClient().removeItemFromWishlist(wishlistId.toString());
    return model;
  }
}