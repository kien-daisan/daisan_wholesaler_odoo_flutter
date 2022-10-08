import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/NotificationModel.dart';

abstract class NotificationState extends Equatable{
  const NotificationState();
  @override
  List<Object> get props => [];
}
class NotificationInitialState extends NotificationState{}

class NotificationSuccessState extends NotificationState{
  final NotificationModel data;
  const NotificationSuccessState(this.data);
}

class NotificationErrorState extends NotificationState{
  final String message;
  const NotificationErrorState(this.message);
}

class NotificationReadSuccessState extends NotificationState{
  final NotificationList data;
  const NotificationReadSuccessState(this.data);
}

class DeleteNotificationState extends NotificationState{
  final NotificationList data;
  const DeleteNotificationState(this.data);
}