import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/extension/value_state_extension.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/item/single_action_bloc_listener.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/paywall_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/purchase_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/ui/widget/paywall_content.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paywallState = context.watch<PaywallCubit>().state;
    final content = paywallState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loaded: PaywallContent.new,
      error: (error) => Text(error.getText(context.l10n)),
    );

    return SingleActionBlocListener<PurchaseCubit>(
      onSuccess: () => context
        ..showSnackBarMessage(context.l10n.success)
        ..pop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.premium),
        ),
        body: Center(
          child: content,
        ),
      ),
    );
  }
}
