import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/purchase_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall.dart';
import 'package:scalable_flutter_app_pro/feature/payment/ui/widget/paywall_product_card.dart';

class PaywallContent extends StatelessWidget {
  const PaywallContent(this.paywall, {super.key});

  final Paywall paywall;

  @override
  Widget build(BuildContext context) {
    final monthly = paywall.monthly;
    final yearly = paywall.yearly;
    final lifetime = paywall.lifetime;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (monthly != null) PaywallProductCard(monthly),
        if (yearly != null) PaywallProductCard(yearly),
        if (lifetime != null) PaywallProductCard(lifetime),
        TextButton(
          onPressed: () => context.read<PurchaseCubit>().restorePurchase(),
          child: Text(context.l10n.restorePurchase),
        ),
      ],
    );
  }
}
