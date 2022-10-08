import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/splash/bloc/splash_screen_repository.dart';


part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent,SplashScreenState>{
  SplashScreenRepository? splashScreenRepository;

  SplashScreenBloc({this.splashScreenRepository}) : super(SplashScreenInitial()){
    on<SplashScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      SplashScreenEvent event, Emitter<SplashScreenState> emit) async {
    if (event is SplashScreenDataFetchEvent) {
      try {
        var model = await splashScreenRepository?.getSplashData();
        if (model != null) {
          emit( SplashScreenSuccess(model));
        } else {
          emit(SplashScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SplashScreenError(error.toString()));
      }
    }
  }



}