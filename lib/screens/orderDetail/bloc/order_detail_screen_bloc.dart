import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/OrderDetailModel.dart';
import 'order_detail_screen_repository.dart';

part 'order_detail_event.dart';

part 'order_detail_screen_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailRepository? repository;

  OrderDetailsBloc({this.repository}) : super(OrderDetailInitial()) {
    on<OrderDetailEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      OrderDetailEvent event, Emitter<OrderDetailState> emit) async {
    if (event is OrderDetailFetchEvent) {
      try {
        var model = await repository?.getOrderDetails(event.orderEndpoint);
        if (model != null) {
          emit(OrderDetailSuccess(model));
        } else {
          emit(OrderDetailError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderDetailError(error.toString()));
      }
    }
  }
}
