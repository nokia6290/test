import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/explore_card.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/bloc/notifications_cubit.dart';

class RemoteNotificationCard extends StatelessWidget {
  const RemoteNotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExploreCard(
      title: context.l10n.remoteNotifications,
      content: Text(context.l10n.remoteNotificationsDescription),
      action: ElevatedButton(
        onPressed: () => _showRemoteNotification(context),
        child: Text(context.l10n.show),
      ),
    );
  }

  void _showRemoteNotification(BuildContext context) {
    context.read<NotificationsCubit>().showRemoteNotification();
  }
}
