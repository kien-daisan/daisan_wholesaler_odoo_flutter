import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/reviewPayments/bloc/review_screen_event.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/reviewPayments/bloc/review_screen_repository.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/reviewPayments/bloc/review_screen_state.dart';




class PaymentReviewScreenBloc extends Bloc<PaymentReviewScreenEvent, PaymentReviewScreenState>{
  PaymentReviewScreenRepository? repository;

  PaymentReviewScreenBloc({this.repository}) : super(PaymentReviewScreenInitial()){
    on<PaymentReviewScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      PaymentReviewScreenEvent event, Emitter<PaymentReviewScreenState> emit) async {
    if (event is GetPaymentMethodEvent) {
      try {
        var model = await repository?.getPaymentMethod();
        if (model != null) {
          emit( GetPaymentMethodSuccess(model));
        } else {
          emit(PaymentReviewScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentReviewScreenError(error.toString()));
      }
    }else if(event is OrderReviewEvent){
      try {
        var model = await repository?.getOrderReviewData(event.shippingAddressId, event.acquirerId, event.shippingId);
        if (model != null) {
          emit( OrderReviewSuccess(model));
        } else {
          emit(PaymentReviewScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentReviewScreenError(error.toString()));
      }
    }else if(event is PlaceOrderEvent){
      try {
        var model = await repository?.placeOrder(event.paymentRefrence , event.transactionId, event.paymentStatus);
        if (model != null) {
          emit( PlaceOrderSuccess(model));
        } else {
          emit(PaymentReviewScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentReviewScreenError(error.toString()));
      }
    }
  }


}