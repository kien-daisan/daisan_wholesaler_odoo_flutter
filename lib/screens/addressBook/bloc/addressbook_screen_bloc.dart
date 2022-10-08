import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/addressBook/bloc/addressbook_screen_repository.dart';
import 'addressbook_screen_event.dart';
import 'addressbook_screen_state.dart';

class AddressBookScreenBloc extends Bloc<AddressBookEvent, AddressBookState> {
  AddressBookRepository? repository;

  AddressBookScreenBloc({this.repository}) : super(AddressBookInitial()) {
    on<AddressBookEvent>(mapEventToState);
  }

  void mapEventToState(
      AddressBookEvent event, Emitter<AddressBookState> emit) async {
    switch (event.runtimeType) {
      case AddressBookDataFetchEvent:
        try {
          var model = await repository?.getAddressList();
          print("qwdqwdwq--${model?.defaultShippingAddressId?.toJson()}");
          if (model != null) {
            emit(AddressBookSuccess(model));
          } else {
            emit(AddressBookError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(AddressBookError(error.toString()));
        }
        break;
      case DeleteAddressEvent:
        emit(AddressBookInitial());
        try {
          var model = await repository
              ?.deleteAddress((event as DeleteAddressEvent).addressId);
          if (model != null && model.success == true) {
            emit(DeleteAddressSuccess(model));
          } else {
            emit(AddressBookError(model?.message??""));
          }
        } catch (error, _) {
          print(error.toString());
          emit(AddressBookError(error.toString()));
        }
    }
  }
}
