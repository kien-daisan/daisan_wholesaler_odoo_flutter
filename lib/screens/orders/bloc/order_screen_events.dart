import 'package:equatable/equatable.dart';

abstract class OrderScreenEvent extends Equatable{
  const OrderScreenEvent();

  @override
  List<Object> get props => [];
}

class OrderScreenDataFetchEvent extends OrderScreenEvent{
  final int offset;
  final int limit;
  const OrderScreenDataFetchEvent(this.offset, this.limit);
}

class OrderDetailsFetchEvent extends OrderScreenEvent{
  final String url;
  const OrderDetailsFetchEvent(this.url);
}
