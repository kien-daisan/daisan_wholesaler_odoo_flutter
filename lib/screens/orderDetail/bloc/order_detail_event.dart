
part of 'order_detail_screen_bloc.dart';

abstract class OrderDetailEvent extends Equatable{
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

class OrderDetailFetchEvent extends OrderDetailEvent{
  String orderEndpoint;
OrderDetailFetchEvent(this.orderEndpoint);
}