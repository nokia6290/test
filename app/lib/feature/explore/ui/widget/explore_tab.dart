import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_app_config.dart';
import 'package:scalable_flutter_app_pro/feature/connectivity/ui/widget/connectivity_card.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/flavor_card.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/ui/widget/local_notification_card.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/ui/widget/remote_notification_card.dart';
import 'package:scalable_flutter_app_pro/feature/payment/ui/widget/paywall_card.dart';
import 'package:scalable_flutter_app_pro/feature/settings/ui/widget/app_review_card.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = context.watchAppConfig;
    final showAppReviewCard = appConfig?.showAppReviewCard ?? false;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const FlavorCard(),
        const ConnectivityCard(),
        const PaywallCard(),
        if (!kIsWeb && showAppReviewCard) const AppReviewCard(),
        if (!kIsWeb) const LocalNotificationCard(),
        if (!kIsWeb) const RemoteNotificationCard(),
      ],
    );
  }
}
