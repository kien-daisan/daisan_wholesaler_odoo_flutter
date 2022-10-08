import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_events.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_repository.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState>{
  NotificationRepositoryImp? repository;
  NotificationBloc({this.repository}): super(NotificationInitialState()){
    on<NotificationEvent>(mapToEvent);
  }

  void mapToEvent(NotificationEvent event, Emitter<NotificationState> emit) async {
    if(event is NotificationDataFetchEvent){
      emit(NotificationInitialState());
      try {
        var data = await repository?.getNotification();
        if (data != null ) {
          emit( NotificationSuccessState(data));
        } else {
          emit(const NotificationErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(NotificationErrorState(error.toString()));
      }
    }
    else if(event is NotificationReadEvent){
      emit(NotificationInitialState());
      try {
        var data = await repository?.markNotification(event.id, event.isRead);
        if (data != null ) {
          emit( NotificationReadSuccessState(data));
        } else {
          emit(const NotificationErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(NotificationErrorState(error.toString()));
      }
    }else if(event is RemoveNotificationEvent){
      emit(NotificationInitialState());
      try {
        var data = await repository?.deleteNotification(event.id);
        if (data != null ) {
          emit(DeleteNotificationState(data));
        } else {
          emit(const NotificationErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(NotificationErrorState(error.toString()));
      }
    }
  }
  }