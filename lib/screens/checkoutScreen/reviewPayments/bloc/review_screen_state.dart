import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';

abstract class PaymentReviewScreenState extends Equatable{
  const PaymentReviewScreenState();

  @override
  List<Object> get props => [];
}

class PaymentReviewScreenInitial extends PaymentReviewScreenState{}

class GetPaymentMethodSuccess extends PaymentReviewScreenState{
  PaymentModel? paymentModel;
  GetPaymentMethodSuccess(this.paymentModel);

  @override
  List<Object> get props => [];

}

class OrderReviewSuccess extends PaymentReviewScreenState{
  OrderReviewModel? orderReviewModel;
  OrderReviewSuccess(this.orderReviewModel);

  @override
  List<Object> get props => [];
}

class PlaceOrderSuccess extends PaymentReviewScreenState{
  PlaceOrderModel? placeOrderModel;
  PlaceOrderSuccess(this.placeOrderModel);

  @override
  List<Object> get props => [];
}


class PaymentReviewScreenError extends PaymentReviewScreenState{
  PaymentReviewScreenError(this._message);

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
