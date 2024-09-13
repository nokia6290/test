import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/model/android_notification_channel.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/model/notification_action.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/repository/notifications_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> with BlocLoggy {
  NotificationsCubit({
    required this.notificationsRepository,
  }) : super(const NotificationsInitial()) {
    _init();
  }

  final NotificationsRepository notificationsRepository;

  StreamSubscription<NotificationAction>? _actionStreamSubscription;

  @override
  Future<void> close() {
    _actionStreamSubscription?.cancel();
    notificationsRepository.close();
    return super.close();
  }

  void showLocalNotification({
    required int id,
    required String title,
    required String message,
    required NotificationMetadata metadata,
    Map<String, dynamic>? payload,
  }) {
    notificationsRepository.showLocalNotification(
      id: id,
      title: title,
      message: message,
      metadata: metadata,
      payload: payload,
    );
  }

  void showRemoteNotification() {
    notificationsRepository.showRemoteNotification();
  }

  Future<void> _init() async {
    await notificationsRepository.init();
    _actionStreamSubscription = notificationsRepository.notificationActionStream
        .listen(_onNotificationAction);

    final action = await notificationsRepository.getInitialNotificationAction();
    if (action == null) {
      emit(const NotificationsLoaded());
      return;
    }

    _onNotificationAction(action);
  }

  void _onNotificationAction(NotificationAction notificationAction) {
    loggy.info('new action: $notificationAction');
    emit(NotificationsLoaded(notificationAction));
  }
}
