import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable{
  const DashboardEvent();
  @override
  List<Object> get props => [];
}

class DashboardDataFetchEvent extends DashboardEvent{
  final int offset;
  final int limit;
  const DashboardDataFetchEvent(this.offset, this.limit);
}

class DashboardOrderFetchEvent extends DashboardEvent{
  final int offset;
  final int limit;
  const DashboardOrderFetchEvent(this.offset, this.limit);
}

class DashboardAddressFetchEvent extends DashboardEvent{}

class ChangeAddressEvent extends DashboardEvent {
  const ChangeAddressEvent();
}
class SaveShippingAddress extends DashboardEvent{
  final String addressId;
  const SaveShippingAddress(this.addressId);
}

class AddImageEvent extends DashboardEvent{
  final String image;
  final String type;
  const AddImageEvent(this.image,this.type);
}

class DeleteImageEvent extends DashboardEvent{
  const DeleteImageEvent();
}

class DeleteBannerImageEvent extends DashboardEvent{
  const DeleteBannerImageEvent();
}






