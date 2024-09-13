import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationsProvider {
  final _messaging = FirebaseMessaging.instance;

  Future<String?> getToken() => _messaging.getToken();

  Stream<String> tokenRefreshStream() => _messaging.onTokenRefresh;

  Stream<RemoteMessage> getForegroundMessageStream() =>
      FirebaseMessaging.onMessage;

  Stream<RemoteMessage> getBackgroundMessageTapStream() =>
      FirebaseMessaging.onMessageOpenedApp;

  Future<RemoteMessage?> getInitialMessage() =>
      FirebaseMessaging.instance.getInitialMessage();
}
