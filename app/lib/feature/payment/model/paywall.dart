import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall_product.dart';

class Paywall {
  const Paywall({
    required this.monthly,
    required this.yearly,
    required this.lifetime,
  });

  factory Paywall.fromRevenueCatOffering(Offering offering) {
    final monthly = offering.monthly;
    final yearly = offering.annual;
    final lifetime = offering.lifetime;

    return Paywall(
      monthly: monthly != null ? RevenueCatPaywallProduct(monthly) : null,
      yearly: yearly != null ? RevenueCatPaywallProduct(yearly) : null,
      lifetime: lifetime != null ? RevenueCatPaywallProduct(lifetime) : null,
    );
  }

  final PaywallProduct? monthly;
  final PaywallProduct? yearly;
  final PaywallProduct? lifetime;
}
