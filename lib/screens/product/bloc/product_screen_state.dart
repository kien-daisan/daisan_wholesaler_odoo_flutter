// part of 'product_screen_bloc';

import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/models/ResponseModel.dart';

abstract class ProductScreenState extends Equatable {
  const ProductScreenState();

  @override
  List<Object> get props => [];
}

class ProductScreenInitial extends ProductScreenState {}

class ProductScreenSuccess extends ProductScreenState {
  ProductScreenSuccess(this.productPageData);

  ProductScreenModel? productPageData;

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ProductScreenError extends ProductScreenState {
  ProductScreenError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class QuantityUpdateState extends ProductScreenState {
  QuantityUpdateState(this.qty);

  int qty = 1;

  @override
  List<Object> get props => [];
}

class AddToWishlistState extends ProductScreenState {
  AddToWishlistState(this.baseModel);
  BaseModel? baseModel;


  @override
  List<Object> get props => [];
}

class RemoveFromWishlist extends ProductScreenState {
  RemoveFromWishlist(this.baseModel);
  BaseModel? baseModel;


  @override
  List<Object> get props => [];
}



class AddtoCartState extends ProductScreenState{
  BaseModel? model;
  AddtoCartState(this.model);

  @override
  List<Object> get props => [];
}

class BuyNowState extends ProductScreenState{
  BaseModel? model;
  BuyNowState(this.model);

  @override
  List<Object> get props => [];
}

class AddReview extends ProductScreenState{
  BaseModel? baseModel;

  AddReview(this.baseModel);

  @override
  List<Object> get props => [];
}
