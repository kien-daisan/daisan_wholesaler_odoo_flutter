
part of 'order_detail_screen_bloc.dart';

abstract class OrderDetailState extends Equatable{
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState{

}

class OrderDetailSuccess extends OrderDetailState{
  OrderDetailModel? model;
  OrderDetailSuccess(this.model);

  @override
  List<Object> get props => [];
}

class OrderDetailError extends OrderDetailState {
  OrderDetailError(this._message);

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