import 'package:equatable/equatable.dart';

abstract class AddressBookEvent extends Equatable {
  const AddressBookEvent();

  @override
  List<Object> get props => [];
}

class AddressBookDataFetchEvent extends AddressBookEvent {
  const AddressBookDataFetchEvent();

  @override
  List<Object> get props => [];
}

class DeleteAddressEvent extends AddressBookEvent{
  const DeleteAddressEvent(this.addressId);
  final String addressId;
}
