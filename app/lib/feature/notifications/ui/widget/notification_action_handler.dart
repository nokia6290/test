import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/bloc/notifications_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/model/notification_action.dart';

class NotificationActionHandler extends StatelessWidget with UiLoggy {
  const NotificationActionHandler({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is! NotificationsLoaded) {
          return;
        }

        final action = state.action;
        if (action is ShowFeedbackPageAction) {
          loggy.info('ShowFeedbackPageAction tapped');
          AppRoute.sendFeedback.push(context);
          return;
        }
      },
      child: child,
    );
  }
}
