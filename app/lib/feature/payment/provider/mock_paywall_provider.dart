import 'dart:async';

import 'package:scalable_flutter_app_pro/feature/payment/model/app_entitlements.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall_product.dart';
import 'package:scalable_flutter_app_pro/feature/payment/provider/paywall_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

class MockPaywallProvider extends PaywallProvider {
  MockPaywallProvider() {
    // Mock no entitlements
    _appEntitlementsStreamController.add(const AppEntitlements(premium: false));
  }

  final StreamController<AppEntitlements> _appEntitlementsStreamController =
      StreamController<AppEntitlements>();

  @override
  Stream<AppEntitlements> get appEntitlementsStream =>
      _appEntitlementsStreamController.stream;

  @override
  void close() {
    _appEntitlementsStreamController.close();
  }

  @override
  Future<Paywall> getPaywall() {
    return Future.delayed(const Duration(seconds: 2), () {
      return const Paywall(
        monthly: MockPaywallProduct(
          id: 'product-monthly',
          name: 'Monthly',
          price: r'$9.99',
        ),
        yearly: MockPaywallProduct(
          id: 'product-yearly',
          name: 'Yearly',
          price: r'$99.99',
        ),
        lifetime: MockPaywallProduct(
          id: 'product-lifetime',
          name: 'Lifetime',
          price: r'$199.99',
        ),
      );
    });
  }

  @override
  Future<void> logOut() async {
    // Do nothing
  }

  @override
  Future<bool> purchase({required PaywallProduct product}) async {
    // Mock network delay
    return Future.delayed(const Duration(seconds: 2), () {
      // Mock successful purchase
      _appEntitlementsStreamController.add(
        const AppEntitlements(premium: true),
      );

      return true;
    });
  }

  @override
  Future<void> restorePurchase() async {
    // Do nothing
  }

  @override
  Future<void> setUser(User? user) async {
    // Do nothing
  }
}
