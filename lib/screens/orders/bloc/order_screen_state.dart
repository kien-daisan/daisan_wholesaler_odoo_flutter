import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';

abstract class OrderScreenState extends Equatable {
  const OrderScreenState();

  @override
  List<Object> get props => [];
}

class OrderScreenInitial extends OrderScreenState{}

class OrderScreenSuccess extends OrderScreenState{
  final OrderModel orders;
  const OrderScreenSuccess(this.orders);
}

class OrderScreenError extends OrderScreenState{
  final String message;
  const OrderScreenError(this.message);
}

class OrderDetailsSuccess extends OrderScreenState{
  final OrderDetailModel data;
  const OrderDetailsSuccess(this.data);
}


