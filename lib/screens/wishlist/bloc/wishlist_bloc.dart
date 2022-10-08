import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_event.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_repository.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_state.dart';

class WishlistScreenBloc extends Bloc<WishlistEvent,WishlistState>{
  WishlistRepository? repository;

  WishlistScreenBloc({this.repository}) : super(WishlistInitialState()){
    on<WishlistEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      WishlistEvent event, Emitter<WishlistState> emit) async {
    if (event is WishlistDataFetchEvent) {
      try {
        var model = await repository?.getWishlistItems();
        if (model != null) {
          emit( WishlistScreenSuccess(model));
        } else {
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    }else if(event is MoveToCartEvent){
      try {
        var model = await repository?.moveToCart(event.productName, event.wishlistId, event.productId);
        if (model != null) {
          emit( MoveToCartSuccess(model));
        } else {
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    }else if(event is RemoveItemEvent){
      try {
        var model = await repository?.removeFromWishlist(event.wishlistId);
        if (model != null) {
          emit(RemoveItemSuccess(model));
        } else {
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    }
  }
}