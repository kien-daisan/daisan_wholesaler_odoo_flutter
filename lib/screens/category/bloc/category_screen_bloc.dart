import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_repository.dart';

import '../../../models/HomeScreenModel.dart';

part 'category_screen_event.dart';
part 'category_screen_state.dart';


class CategoryScreenBloc extends Bloc<CategoryScreenEvent, CategoryScreenState>{
  CategoryScreenRepository? repository;
  CategoryScreenBloc(this.repository): super(CategoryScreenInitial()){
    on<CategoryScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      CategoryScreenEvent event, Emitter<CategoryScreenState> emit) async {
    if (event is CategoryScreenDataFetchEvent) {
      try {
        var model = await repository?.getCategoryPage(event.categoryId,event.limit,event.offset);
        if (model != null) {
          emit( CategoryScreenSuccess(model));
        } else {
          emit(CategoryScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CategoryScreenError(error.toString()));
      }
    }else if (event is CategoryHomeFetchEvent) {
      try {
        var model = await repository?.getHomeData();
        if (model != null) {
          emit( CategoryHomeApiSuccess(model));
        } else {
          emit(CategoryScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CategoryScreenError(error.toString()));
      }
    }
  }

}