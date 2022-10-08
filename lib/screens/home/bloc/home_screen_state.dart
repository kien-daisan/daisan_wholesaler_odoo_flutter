part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenSuccess extends HomeScreenState {
   HomeScreenSuccess(this.homePageData);

  HomePageData? homePageData;

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class HomeScreenError extends HomeScreenState {
  HomeScreenError(this._message);

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
