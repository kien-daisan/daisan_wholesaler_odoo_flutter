import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';

import '../../../../models/ShippingMethodModel.dart';

abstract class CheckoutScreenState extends Equatable {
  const CheckoutScreenState();

  @override
  List<Object> get props => [];
}

class CheckoutScreenInitial extends CheckoutScreenState {}

class ShippingAddressSuccess extends CheckoutScreenState {
  final AddressListModel model;

  const ShippingAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class ShippingMethodSuccess extends CheckoutScreenState {
  final ShippingMethodModel model;

  const ShippingMethodSuccess(this.model);

  @override
  List<Object> get props => [];
}

class CheckoutError extends CheckoutScreenState {
  CheckoutError(this._message);

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

class ChangeShippingAddressState extends CheckoutScreenState {
  const ChangeShippingAddressState();
}
