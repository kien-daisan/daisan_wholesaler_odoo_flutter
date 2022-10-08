


part of 'catalog_screen_bloc.dart';



abstract class CatalogScreenState extends Equatable{
  const CatalogScreenState();
  @override
  List<Object> get props => [];
}

class CatalogScreenInitialState extends CatalogScreenState{}

class CatalogScreenSuccessState extends CatalogScreenState{
  CategoryScreenModel? categoryScreenModel;
  CatalogScreenSuccessState(this.categoryScreenModel);
}

class CatalogDataFromNotificationSuccessState extends CatalogScreenState{
  CategoryScreenModel? categoryScreenModel;
  CatalogDataFromNotificationSuccessState(this.categoryScreenModel);
}


class CatalogScreenErrorState extends CatalogScreenState{
  CatalogScreenErrorState(this._message);

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

class CatalogScreenCompleteState extends CatalogScreenState{}


