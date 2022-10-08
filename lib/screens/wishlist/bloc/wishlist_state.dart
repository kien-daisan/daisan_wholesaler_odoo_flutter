import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/WishlistModel.dart';

import '../../../models/BaseModel.dart';

abstract class WishlistState extends Equatable{
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitialState extends WishlistState{

}

class WishlistScreenSuccess extends WishlistState{
  WishlistModel? wishlistModel;

  WishlistScreenSuccess(this.wishlistModel);

  @override
  List<Object> get props => [];
}

class MoveToCartSuccess extends WishlistState{
  BaseModel? baseModel;

  MoveToCartSuccess(this.baseModel);

  @override
  List<Object> get props => [];
}

class WishlistActionState extends WishlistState{

}

class RemoveItemSuccess extends WishlistState{
  BaseModel? baseModel;

  RemoveItemSuccess(this.baseModel);

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WishlistScreenError extends WishlistState {
  WishlistScreenError(this._message);

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