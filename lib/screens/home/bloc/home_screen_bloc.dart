import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_repository.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenRepository? repository;

  HomeScreenBloc({this.repository}) : super(HomeScreenInitial()) {
    on<HomeScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    if (event is HomeScreenDataFetchEvent) {
      emit(HomeScreenInitial());
      try {
        var model = await repository?.getHomeData();
        if (model != null) {
          emit( HomeScreenSuccess(model));
        } else {
          emit(HomeScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(HomeScreenError(error.toString()));
      }
    }
  }
}
