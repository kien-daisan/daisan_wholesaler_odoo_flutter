import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_events.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_repository.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_state.dart';

class SearchScreenBloc extends Bloc<SearchEvent,SearchState>{
  SearchRepository? repository;

  SearchScreenBloc({this.repository}) : super(SearchInitialState()){
    on<SearchEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      SearchEvent event, Emitter<SearchState> emit) async {
    if(event is InitialSearchSuggestionEvent){
      emit(SearchInitialState());
      try {
        var model = await repository?.getSearchSuggestion('');
        if (model != null) {
          emit( SearchScreenSuccess(model));
        } else {
          emit(SearchScreenError(''));
        }
      } catch (error, sT) {
        print(sT.toString());
        emit(SearchScreenError(error.toString()));
      }
    }
    else if (event is SearchSuggestionEvent) {
      emit(SearchInitialState());
      try {
        var model = await repository?.getSearchSuggestion(event.searchKey);
        if (model != null) {
          emit( SearchScreenSuccess(model));
        } else {
          emit(SearchScreenError(''));
        }
      } catch (error, sT) {
        print(sT.toString());
        emit(SearchScreenError(error.toString()));
      }
    }
  }
}