import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable{
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class WishlistDataFetchEvent extends WishlistEvent{

}

class MoveToCartEvent extends WishlistEvent{
  final String productName;
  final int wishlistId;
  final int productId;

  const MoveToCartEvent(this.productName,this.wishlistId,this.productId);

  @override
  List<Object> get props => [];

}

class RemoveItemEvent extends WishlistEvent{
  final int wishlistId;

  const RemoveItemEvent(this.wishlistId);

  @override
  List<Object> get props => [];
}