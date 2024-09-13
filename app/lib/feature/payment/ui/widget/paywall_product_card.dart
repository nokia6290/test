import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/purchase_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall_product.dart';

class PaywallProductCard extends StatelessWidget {
  const PaywallProductCard(this.product, {super.key});

  final PaywallProduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.read<PurchaseCubit>().purchase(product),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(product.name),
              const Spacer(),
              Text(product.price),
            ],
          ),
        ),
      ),
    );
  }
}
