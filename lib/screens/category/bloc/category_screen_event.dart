part of 'category_screen_bloc.dart';

abstract class CategoryScreenEvent {
  const CategoryScreenEvent();

  @override
  List<Object> get props => [];
}

class CategoryScreenDataFetchEvent extends CategoryScreenEvent {
  const CategoryScreenDataFetchEvent(this.categoryId,this.limit,this.offset);

  final int categoryId;
  final int limit;
  final int offset;

  @override
  List<Object> get props => [];

}

class CategoryHomeFetchEvent extends CategoryScreenEvent {
  @override
  List<Object> get props => [];

}
