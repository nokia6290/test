import 'package:scalable_flutter_app_pro/core/logger/logger.dart';

sealed class NotificationAction {
  const NotificationAction();

  static NotificationAction? fromPayload(Map<String, dynamic> payload) {
    switch (payload['type']) {
      case 'feedback':
        return const ShowFeedbackPageAction();

      default:
        logWarning('unexpected notification: $payload');
        return null;
    }
  }
}

class ShowFeedbackPageAction extends NotificationAction {
  const ShowFeedbackPageAction();
}
