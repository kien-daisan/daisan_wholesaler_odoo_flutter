import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategory_screen_repository.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategory_screen_state.dart';
import 'subcategory_screen_event.dart';



class SubcategoryBloc extends Bloc<SubCategoryScreenEvent, SubCategoryState>{
  SubCategoryRepository? repository;

  SubcategoryBloc({this.repository}) : super(SubCategoryInitialState()){
    on<SubCategoryScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SubCategoryScreenEvent event, Emitter<SubCategoryState> emit) async {
    if (event is SubCategoryScreenDatFetchEvent) {
      try {
        var model = await repository?.getCategoryPage(event.categoryId,event.limit,event.offset);
        if (model != null) {
          emit( SubCategorySuccessState(model));
        } else {
          emit(SubCategoryErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SubCategoryErrorState(error.toString()));
      }
    }
  }
}