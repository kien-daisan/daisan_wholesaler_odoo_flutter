import 'package:equatable/equatable.dart';

abstract class CartScreenEvent extends Equatable{
  const CartScreenEvent();

  @override
  List<Object> get props => [];
}

class CartScreenDataFetchEvent extends CartScreenEvent {
  const CartScreenDataFetchEvent();

  @override
  List<Object> get props => [];
}

class RemoveCartItem extends CartScreenEvent{
  final int lineId;
   const RemoveCartItem(this.lineId);
  @override
  List<Object> get props => [];
}

class CartToWishlistEvent extends CartScreenEvent{
  final String productName;
  final int lineId;

  const CartToWishlistEvent(this.productName,this.lineId);
}

class SetCartEmpty extends CartScreenEvent{

  const SetCartEmpty();
}

class SetCartItemQuantityEvent extends CartScreenEvent{
  final int lineId;
  final int qty;

  const SetCartItemQuantityEvent(this.lineId,this.qty);
}