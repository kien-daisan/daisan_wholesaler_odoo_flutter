import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/GooglePlaceModel.dart';

abstract class LocationScreenState extends Equatable{
  @override
  List<Object> get props => [];
}
class LocationScreenInitialState extends LocationScreenState{}
class LocationScreenLoadingState extends LocationScreenState{}

class SearchPlaceSuccessState extends LocationScreenState{
final GooglePlaceModel data;
SearchPlaceSuccessState(this.data);
}

class SearchPlaceErrorState extends LocationScreenState{
  final String message;
  SearchPlaceErrorState(this.message);
}

class CompleteState extends LocationScreenState{}
