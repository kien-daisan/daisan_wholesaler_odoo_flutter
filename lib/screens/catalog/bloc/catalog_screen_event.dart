
part of 'catalog_screen_bloc.dart';

abstract class CatalogScreenEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class CatalogScreenDataFetchEvent extends CatalogScreenEvent{
  CatalogScreenDataFetchEvent(this.categoryId,this.limit,this.offset);

  final int categoryId;
  final int limit;
  final int offset;

  @override
  List<Object> get props => [];
}

class CatalogScreenDataFetchFromHomeEvent extends CatalogScreenEvent{
  CatalogScreenDataFetchFromHomeEvent(this.url,this.limit,this.offset);
 final String url;
  final int limit;
  final int offset;

  @override
  List<Object> get props => [];
}

class CatalogScreenDataFetchFromNotificationEvent extends CatalogScreenEvent{
  CatalogScreenDataFetchFromNotificationEvent(this.limit,this.domain);
  final int limit;
  final String domain;

  @override
  List<Object> get props => [];
}


