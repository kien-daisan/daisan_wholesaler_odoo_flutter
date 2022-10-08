import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/NotificationModel.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_bloc.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_events.dart';
import 'package:flutter_project_structure/screens/Notification/bloc/notification_state.dart';
import 'package:flutter_project_structure/screens/Notification/views/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = false;
  NotificationBloc? _notificationBloc;
  AppLocalizations? _localizations;
  NotificationModel? data;
  NotificationList? readNotification;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _notificationBloc = context.read<NotificationBloc>();
    _notificationBloc?.add(const NotificationDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder:(context, currentState){
          if(currentState is NotificationInitialState){
            isLoading = true;
          }
          else if(currentState is NotificationSuccessState){
            isLoading = false;
            data = currentState.data;
          }
          else if(currentState is NotificationErrorState){
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message , context);
            });
          }
          else if(currentState is NotificationReadSuccessState){
            isLoading  = false;
            readNotification = currentState.data;
          }else if(currentState is DeleteNotificationState){
            isLoading = false;
            readNotification = currentState.data;
          }
          return _buildUI();
        }
        );
  }

  Widget _buildUI(){
    return Stack(
      children: [
        Scaffold(
          appBar: commonToolBar(_localizations?.translate(AppStringConstant.notifications) ?? '', context, isLeadingEnable: true, isElevated: true),
          body: (data != null)
              ? (data?.notificationList?.isNotEmpty ?? false)
              ? ListView.builder(
            itemCount: data?.notificationList?.length ?? 0,
              itemBuilder: (context, index) => Dismissible(
                key: Key(data?.notificationList![index].id.toString() ?? "0"),
                onDismissed: (direction){
                  setState(() {
                    _notificationBloc?.add(RemoveNotificationEvent(data?.notificationList![index].id ?? 0));
                    data?.notificationList?.removeAt(index);
                    _notificationBloc?.emit(NotificationSuccessState(data!));
                  });
                },
                child: NotificationItem(data?.notificationList?[index], (id, isRead){
                  _notificationBloc?.add(NotificationReadEvent(id , isRead));
                }),
              ))
              : emptyNotification()
          : Container(),
        ),
        Visibility(
            visible: isLoading,
            child: Loader())
      ],
    );
  }
  Widget emptyNotification(){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         const  Icon(Icons.notifications, size: 160,),
          Text(_localizations?.translate(AppStringConstant.emptyNotification) ?? '', style:  Theme.of(context).textTheme.headline4,),
        ],
      ),
    );
  }
}
