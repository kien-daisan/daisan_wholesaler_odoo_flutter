import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/screens/catalog/bloc/catalog_screen_repository.dart';
part 'catalog_screen_event.dart';
part 'catalog_screen_state.dart';

class CatalogScreenBloc extends Bloc<CatalogScreenEvent, CatalogScreenState>{
  CatalogScreenRepository? repository;
  CatalogScreenBloc({this.repository}) : super(CatalogScreenInitialState()){
    on<CatalogScreenEvent>(mapEventToState);

  }

  void mapEventToState(
      CatalogScreenEvent event, Emitter<CatalogScreenState> emit) async {
    if (event is CatalogScreenDataFetchEvent) {
      try {
        var model = await repository?.getCategoryPage(event.categoryId,event.limit,event.offset);
        if (model != null) {
          emit( CatalogScreenSuccessState(model));
        } else {
          emit(CatalogScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CatalogScreenErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3),(){
        emit(CatalogScreenCompleteState());
      });
    }else if(event is CatalogScreenDataFetchFromHomeEvent){
      try {
        var model = await repository?.getCatalogDatafromHome(event.url,event.limit,event.offset);
        if (model != null) {
          emit( CatalogScreenSuccessState(model));
        } else {
          emit(CatalogScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CatalogScreenErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3),(){
        emit(CatalogScreenCompleteState());
      });
    }
    else if(event is CatalogScreenDataFetchFromNotificationEvent){
      try {
        var model = await repository?.getCatalogDataFromNotification(event.limit, event.domain);
        if (model != null) {
          emit( CatalogDataFromNotificationSuccessState(model));
        } else {
          emit(CatalogScreenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CatalogScreenErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3),(){
        emit(CatalogScreenCompleteState());
      });
    }

  }

}