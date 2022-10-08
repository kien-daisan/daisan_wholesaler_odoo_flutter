import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';

abstract class CartScreenState extends Equatable{
  const CartScreenState();

  @override
  List<Object> get props => [];

}

class CartScreenInitial extends CartScreenState{}

class CartScreenSuccess extends CartScreenState{
 final  CartViewModel model;

  const CartScreenSuccess(this.model);

  @override
  List<Object> get props => [];
}

class RemoveCartItemSuccess extends CartScreenState {
  const RemoveCartItemSuccess(this.data);

  final BaseModel data;

  @override
  List<Object> get props => [data];
}

class CartToWishlistState extends CartScreenState{
  final BaseModel data;

  const CartToWishlistState(this.data);

  @override
  List<Object> get props => [data];
}

class SetCartEmptyState extends CartScreenState{
  final BaseModel data;

  const SetCartEmptyState(this.data);

  @override
  List<Object> get props => [data];
}

class SetCartItemQtyState extends CartScreenState{
  final BaseModel data;

  const SetCartItemQtyState(this.data);

  @override
  List<Object> get props => [data];
}

class CartScreenError extends CartScreenState{
  CartScreenError(this._message);
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