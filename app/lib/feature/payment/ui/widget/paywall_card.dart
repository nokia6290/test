import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_app_entitlements.dart';
import 'package:scalable_flutter_app_pro/core/extension/value_state_extension.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/explore_card.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/app_entitlements_cubit.dart';

class PaywallCard extends StatelessWidget {
  const PaywallCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appEntitlementsState = context.watch<AppEntitlementsCubit>().state;
    final content = appEntitlementsState.when(
      initial: () => const Text('-'),
      loaded: (appEntitlements) => Icon(
        appEntitlements.premium ? Icons.check : Icons.close,
        color: appEntitlements.premium ? Colors.green : Colors.red,
      ),
      error: (error) => Text(error.getText(context.l10n)),
    );

    return ExploreCard(
      title: context.l10n.premium,
      content: content,
      action: ElevatedButton(
        onPressed: () => _onPressed(context),
        child: Text(context.l10n.premium),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    final appEntitlements = context.getAppEntitlements;
    if (appEntitlements?.premium ?? false) {
      logInfo('Already premium');
      return;
    }

    AppRoute.paywall.push(context);
  }
}
