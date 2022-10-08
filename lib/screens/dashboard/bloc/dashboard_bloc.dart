import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_events.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_repository.dart';
import 'package:flutter_project_structure/screens/dashboard/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState>{
  DashboardRepositoryImp? repository;
  DashboardBloc({this.repository}): super(DashboardLoadingState()){
    on<DashboardEvent>(mapToEvent);
  }
 void mapToEvent(DashboardEvent event, Emitter<DashboardState> emit) async{
    if(event is DashboardDataFetchEvent){
      emit(DashboardLoadingState());
      try {
        var orderList = await repository?.getOrderList(event.offset, event.limit);
        var addressList = await repository?.getAddressList();
        if (orderList != null && addressList != null) {
          emit( DashboardSuccessState(orderList, addressList));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
    else if(event is DashboardOrderFetchEvent){
      emit(DashboardLoadingState());
      try {
        var orderList = await repository?.getOrderList(event.offset, event.limit);
        if (orderList != null ) {
          emit( DashboardOrderSuccessState(orderList));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
    else if(event is DashboardAddressFetchEvent){
      emit(DashboardLoadingState());
      try {
        var addressList = await repository?.getAddressList();
        if ( addressList != null) {
          emit( DashboardAddressSuccessState( addressList));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
    else if(event is ChangeAddressEvent){
      emit( ChangeShippingAddressState());
    }
    else if(event is SaveShippingAddress){
      emit(DashboardLoadingState());
      try {
        var addressList = await repository?.saveDefaultShipping(event.addressId);
        if ( addressList != null) {
          emit( SaveShippingAddressState( addressList));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
    else if(event is AddImageEvent){
      emit(DashboardLoadingState());
      try {
        var model = await repository?.setImage(event.image, event.type);
        if (model != null) {
          emit( AddImageState(model));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
    else if(event is DeleteImageEvent){
      emit(DashboardLoadingState());
      try {
        var model = await repository?.deleteImage();
        if (model != null) {
          emit( DeleteImageState(model));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
    else if(event is DeleteBannerImageEvent){
      emit(DashboardLoadingState());
      try {
        var model = await repository?.deleteImage();
        if (model != null) {
          emit(DeleteBannerImageState(model));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }

 }
}