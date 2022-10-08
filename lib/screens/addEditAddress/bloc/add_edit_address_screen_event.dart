import 'package:equatable/equatable.dart';

abstract class AddEditAddressEvent extends Equatable {
  const AddEditAddressEvent();

  @override
  List<Object> get props => [];
}

class AddEditAddressDataFetchEvent extends AddEditAddressEvent {
  const AddEditAddressDataFetchEvent();

  @override
  List<Object> get props => [];
}

class AddressDetailFetchEvent extends AddEditAddressEvent {
  final String endPoint;

  AddressDetailFetchEvent(this.endPoint);

  @override
  List<Object> get props => [];
}

class UpdateAddressEvent extends AddEditAddressEvent {
  final String endPoint, name, phone, street, city, zip, countryId, stateId;

  UpdateAddressEvent(this.endPoint, this.name, this.phone, this.street,
      this.city, this.zip, this.countryId, this.stateId);

  @override
  List<Object> get props => [];
}

class AddAddressEvent extends AddEditAddressEvent {
  final String name, phone, street, city, zip, countryId, stateId;

  AddAddressEvent(this.name, this.phone, this.street, this.city, this.zip,
      this.countryId, this.stateId);

  @override
  List<Object> get props => [];
}
