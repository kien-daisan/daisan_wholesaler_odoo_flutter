import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';

abstract class AddressBookState extends Equatable {
  const AddressBookState();

  @override
  List<Object> get props => [];
}

class AddressBookInitial extends AddressBookState {}

class AddressBookSuccess extends AddressBookState {
  final AddressListModel model;

  const AddressBookSuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddressBookError extends AddressBookState {
  AddressBookError(this._message);

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

class DeleteAddressSuccess extends AddressBookState{
  const DeleteAddressSuccess(this.model);
  final BaseModel model;
}
