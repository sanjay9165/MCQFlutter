import '../../models/notification_model.dart';

abstract class NotificationState{}

class NotificationInitial extends NotificationState{}

class NotificationFetchState extends NotificationState{}

class NotificationFetchLoadingState extends NotificationFetchState{}

class NotificationFetchSuccessState extends NotificationFetchState{
 final List<NotificationModel>allNotifications;

  NotificationFetchSuccessState({required this.allNotifications});
}

class NotificationFetchErrorState extends NotificationFetchState{
  final String error;

  NotificationFetchErrorState({required this.error});
}