import 'package:scalable_flutter_app_pro/feature/payment/model/app_entitlements.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall_product.dart';
import 'package:scalable_flutter_app_pro/feature/payment/provider/paywall_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

class PaymentRepository {
  const PaymentRepository({
    required this.paywallProvider,
  });

  final PaywallProvider paywallProvider;

  Stream<AppEntitlements> get appEntitlementsStream =>
      paywallProvider.appEntitlementsStream;

  Future<Paywall> getPaywall() {
    return paywallProvider.getPaywall();
  }

  Future<bool> purchase(PaywallProduct product) {
    return paywallProvider.purchase(product: product);
  }

  Future<void> restorePurchase() {
    return paywallProvider.restorePurchase();
  }

  void setUser(User? user) {
    paywallProvider.setUser(user);
  }

  void close() {
    paywallProvider.close();
  }
}
