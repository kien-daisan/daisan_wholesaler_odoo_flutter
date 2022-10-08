import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_repository.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';

class CartScreenBloc extends Bloc<CartScreenEvent, CartScreenState>{
  CartScreenRepository? repository;
  CartScreenBloc({this.repository}) : super(CartScreenInitial()){
    on<CartScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      CartScreenEvent event, Emitter<CartScreenState> emit) async {
    switch(event.runtimeType){
      case CartScreenDataFetchEvent:
        try {
          var model = await repository?.getCartData();
          if (model != null) {
            emit( CartScreenSuccess(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;

      case RemoveCartItem:
        try {
          var model = await repository?.removeCartItem((event as RemoveCartItem).lineId);
          if (model != null) {
            emit( RemoveCartItemSuccess(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case CartToWishlistEvent:
        try {
          var model = await repository?.cartToWishlist((event as CartToWishlistEvent).productName, (event).lineId);
          if (model != null) {
            emit( CartToWishlistState(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case SetCartEmpty:
        try {
          var model = await repository?.setCartEmpty();
          if (model != null) {
            emit( SetCartEmptyState(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case SetCartItemQuantityEvent:
        try {
          var model = await repository?.setCartItemQty((event as SetCartItemQuantityEvent).lineId, event.qty);
          if (model != null) {
            emit( SetCartItemQtyState(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        } 
    }

  }

}