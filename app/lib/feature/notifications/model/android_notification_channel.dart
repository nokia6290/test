sealed class NotificationMetadata {
  const NotificationMetadata({
    required this.androidChannelId,
    required this.androidChannelTitle,
    required this.androidChannelDescription,
  });

  final String androidChannelId;
  final String androidChannelTitle;
  final String androidChannelDescription;
}

class DefaultNotificationMetadata extends NotificationMetadata {
  const DefaultNotificationMetadata()
      : super(
          androidChannelId: 'default',
          androidChannelTitle: 'Default',
          androidChannelDescription: 'Default notification channel',
        );
}
