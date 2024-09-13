import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loggy/loggy.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/model/android_notification_channel.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/model/notification_action.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/provider/firebase_notifications_provider.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/provider/local_notifications_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/provider/user_cloud_functions_provider.dart';

typedef NotificationTapCallback = void Function(String? payload);

class NotificationsRepository with RepositoryLoggy {
  NotificationsRepository({
    required this.localNotificationsProvider,
    required this.firebaseNotificationsProvider,
    required this.cloudFunctions,
  });

  final LocalNotificationsProvider localNotificationsProvider;
  final FirebaseNotificationsProvider firebaseNotificationsProvider;
  final UserCloudFunctionsProvider cloudFunctions;

  final _notificationActionController = StreamController<NotificationAction>();

  Stream<NotificationAction> get notificationActionStream =>
      _notificationActionController.stream;

  Future<void> init() async {
    await localNotificationsProvider.init(
      onNotificationTap: _onLocalNotificationTap,
    );

    firebaseNotificationsProvider.tokenRefreshStream().listen((token) {
      cloudFunctions.addUserFcmToken(token: token);
    });

    firebaseNotificationsProvider
        .getForegroundMessageStream()
        .listen(_onRemoteForegroundMessage);

    firebaseNotificationsProvider
        .getBackgroundMessageTapStream()
        .listen(_onRemoteNotificationTap);
  }

  Future<NotificationAction?> getInitialNotificationAction() async {
    final initialMessage =
        await firebaseNotificationsProvider.getInitialMessage();
    if (initialMessage == null) {
      return null;
    }

    return NotificationAction.fromPayload(initialMessage.data);
  }

  Future<void> addFcmToken() async {
    final token = await firebaseNotificationsProvider.getToken();
    if (token != null) {
      await cloudFunctions.addUserFcmToken(token: token);
    }
  }

  Future<void> removeFcmToken() async {
    final token = await firebaseNotificationsProvider.getToken();
    if (token != null) {
      await cloudFunctions.removeUserFcmToken(token: token);
    }
  }

  void close() {
    _notificationActionController.close();
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String message,
    required NotificationMetadata metadata,
    Map<String, dynamic>? payload,
  }) async {
    await localNotificationsProvider.requestPermission();
    await localNotificationsProvider.show(
      id: id,
      title: title,
      message: message,
      metadata: metadata,
      payload: payload == null ? null : jsonEncode(payload),
    );
  }

  Future<void> showRemoteNotification() {
    return cloudFunctions.sendUserNotification();
  }

  void _onLocalNotificationTap(String? payload) {
    if (payload == null) {
      return;
    }

    final data = jsonDecode(payload) as Map<String, dynamic>;
    _onNotificationTap(data);
  }

  void _onRemoteNotificationTap(RemoteMessage remoteMessage) {
    _onNotificationTap(remoteMessage.data);
  }

  void _onNotificationTap(Map<String, dynamic> data) {
    final action = NotificationAction.fromPayload(data);
    if (action != null) {
      _notificationActionController.add(action);
    }
  }

  void _onRemoteForegroundMessage(RemoteMessage remoteMessage) {
    logInfo('onRemoteForegroundMessage: ${remoteMessage.toMap()}');
    final notification = remoteMessage.notification;
    if (notification == null) {
      logInfo('onRemoteForegroundMessage: no notification (only data)');
      return;
    }

    // You can show a local notification here:
    // localNotificationsProvider.show(...)
  }
}
