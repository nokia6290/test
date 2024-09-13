import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/model/android_notification_channel.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/repository/notifications_repository.dart';

class LocalNotificationsProvider with ProviderLoggy {
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init({
    required NotificationTapCallback onNotificationTap,
  }) async {
    const androidSettings = AndroidInitializationSettings(
      'drawable/ic_notification',
    );
    const iosSettings = DarwinInitializationSettings(
      // We don't want to request permissions on app start.
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
        macOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        loggy.info('_onNotificationResponse: $payload');
        onNotificationTap(payload);
      },
    );
  }

  Future<void> show({
    required int id,
    required String title,
    required String message,
    required NotificationMetadata metadata,
    String? payload,
  }) {
    return _localNotifications.show(
      id,
      title,
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          metadata.androidChannelId,
          metadata.androidChannelTitle,
          channelDescription: metadata.androidChannelDescription,
        ),
      ),
      payload: payload,
    );
  }

  Future<void> requestPermission() async {
    if (Platform.isIOS) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
