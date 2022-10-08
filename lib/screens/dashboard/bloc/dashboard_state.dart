import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';

abstract class DashboardState extends Equatable{
  const DashboardState();
  @override
  List<Object> get props => [];
}

class DashboardLoadingState extends DashboardState{}

class DashboardSuccessState extends DashboardState{
  final OrderModel order;
  final AddressListModel address;
  const DashboardSuccessState(this.order, this.address);
}

class DashboardErrorState extends DashboardState{
  final String message;
  const DashboardErrorState(this.message);
}

class DashboardOrderSuccessState extends DashboardState{
  final OrderModel order;
  const DashboardOrderSuccessState(this.order);
}

class DashboardAddressSuccessState extends DashboardState{
  final AddressListModel address;
  const DashboardAddressSuccessState(this.address);
}
 class ChangeShippingAddressState extends DashboardState{}

class SaveShippingAddressState extends DashboardState{
  final BaseModel data;
  const SaveShippingAddressState(this.data);
}

class AddImageState extends DashboardState{
  final AccountInfoModel? model;
  const AddImageState(this.model);
}

class DeleteImageState extends DashboardState{
  final BaseModel? model;
  const DeleteImageState(this.model);
}
class DeleteBannerImageState extends DashboardState{
  final BaseModel? model;
  const DeleteBannerImageState(this.model);
}