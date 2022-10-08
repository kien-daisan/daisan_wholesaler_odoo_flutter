import 'package:flutter_bloc/flutter_bloc.dart';

import 'checkout_screen_event.dart';
import 'checkout_screen_repository.dart';
import 'checkout_screen_state.dart';


class CheckoutScreenBloc
    extends Bloc<CheckoutScreenEvent, CheckoutScreenState> {
  CheckoutScreenRepositoryImp? repository;

  CheckoutScreenBloc({this.repository}) : super(CheckoutScreenInitial()) {
    on<CheckoutScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      CheckoutScreenEvent event, Emitter<CheckoutScreenState> emit) async {
    switch (event.runtimeType) {
      case ShippingAddressFetchEvent:
        try {
          var model = await repository?.getShippingAddress();
          print("qwdqwdwq--${model?.defaultShippingAddressId?.toJson()}");
          if (model != null) {
            emit(ShippingAddressSuccess(model));
          } else {
            emit(CheckoutError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CheckoutError(error.toString()));
        }
        break;
      case ShippingMethodsFetchEvent:
        try {
          var model = await repository?.getShippingMethods();

          if (model != null) {
            emit(ShippingMethodSuccess(model));
          } else {
            emit(CheckoutError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CheckoutError(error.toString()));
        }
        break;
      case ChangeAddressEvent:
        emit(const ChangeShippingAddressState());
        break;
    }
  }
}
