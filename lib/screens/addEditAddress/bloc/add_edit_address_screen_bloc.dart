import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/addEditAddress/bloc/add_edit_address_screen_event.dart';

import 'add_edit__address_repository.dart';
import 'add_edit_address_state.dart';

class AddEditAddressScreenBloc
    extends Bloc<AddEditAddressEvent, AddEditAddressState> {
  AddEditAddressRepository? repository;

  AddEditAddressScreenBloc({this.repository}) : super(AddEditAddressInitial()) {
    on<AddEditAddressEvent>(mapEventToState);
  }

  void mapEventToState(
      AddEditAddressEvent event, Emitter<AddEditAddressState> emit) async {
    switch (event.runtimeType) {
      case AddEditAddressDataFetchEvent:
        try {
          var model = await repository?.getCountryList();
          if (model != null) {
            emit(AddEditAddressCountrySuccess(model));
          } else {
            emit(AddEditAddressError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(AddEditAddressError(error.toString()));
        }
        break;
      case AddressDetailFetchEvent:
        try {
          var model = await repository
              ?.getAddressDetails((event as AddressDetailFetchEvent).endPoint);
          if (model != null) {
            emit(AddressDetailFetchSuccess(model));
          } else {
            emit(AddEditAddressError(''));
          }
        } catch (error, _) {
          emit(AddEditAddressError(error.toString()));
        }
        break;
      case UpdateAddressEvent:
        try {
          (event as UpdateAddressEvent);
          var model = await repository?.updateAddress(
              event.endPoint,
              event.name,
              event.phone,
              event.street,
              event.city,
              event.zip,
              event.countryId,
              event.stateId);
          if (model != null) {
            emit(UpdateAddressSuccess(model));
          } else {
            emit(AddEditAddressError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(AddEditAddressError(error.toString()));
        }
        break;
      case AddAddressEvent:
        try {
          (event as AddAddressEvent);
          var model = await repository?.addNewAddress(
              event.name,
              event.phone,
              event.street,
              event.city,
              event.zip,
              event.countryId,
              event.stateId);
          if (model != null) {
            emit(AddAddressSuccess(model));
          } else {
            emit(AddEditAddressError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(AddEditAddressError(error.toString()));
        }
        break;
    }
  }
}
