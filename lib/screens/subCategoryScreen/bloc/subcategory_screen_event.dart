import 'package:equatable/equatable.dart';

abstract class SubCategoryScreenEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SubCategoryScreenDatFetchEvent extends SubCategoryScreenEvent{
  SubCategoryScreenDatFetchEvent(this.categoryId,this.limit,this.offset);

  final int categoryId;
  final int limit;
  final int offset;

  @override
  List<Object> get props => [];
}