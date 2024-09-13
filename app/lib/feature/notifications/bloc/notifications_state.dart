part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded([this.action]);

  final NotificationAction? action;
}
