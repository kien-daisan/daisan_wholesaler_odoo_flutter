import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable{
 const NotificationEvent();
  @override
  List<Object> get props => [];
}

class NotificationDataFetchEvent extends NotificationEvent{
 const NotificationDataFetchEvent();
}

class NotificationReadEvent extends NotificationEvent{
 final bool isRead;
 final int id;
 const NotificationReadEvent(this.id, this.isRead);
}

class RemoveNotificationEvent extends NotificationEvent{
 final int id;

 RemoveNotificationEvent(this.id);
}
