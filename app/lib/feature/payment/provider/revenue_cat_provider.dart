import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/app_entitlements.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall_product.dart';
import 'package:scalable_flutter_app_pro/feature/payment/provider/paywall_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

const _androidApiKey = 'YOUR_REVENUE_CAT_ANDROID_API_KEY';
const _iosApiKey = 'YOUR_REVENUE_CAT_IOS_API_KEY';

const _revenueCatPremiumEntitlement = 'premium';

class RevenueCatProvider extends PaywallProvider {
  RevenueCatProvider() {
    Purchases.addCustomerInfoUpdateListener(_customerInfoStreamController.add);
  }

  static Future<void> init() async {
    await Purchases.setLogLevel(
      kReleaseMode ? LogLevel.warn : LogLevel.debug,
    );
    await Purchases.configure(
      PurchasesConfiguration(Platform.isAndroid ? _androidApiKey : _iosApiKey),
    );
  }

  @override
  void close() {
    _customerInfoStreamController.close();
  }

  final StreamController<CustomerInfo> _customerInfoStreamController =
      StreamController<CustomerInfo>();

  @override
  Stream<AppEntitlements> get appEntitlementsStream =>
      _customerInfoStreamController.stream.map(_toAppEntitlements);

  @override
  Future<void> setUser(User? user) async {
    if (user == null) {
      return;
    }

    final userId = user.id;
    final email = user.email;
    final name = user.name;

    await Purchases.logIn(userId);
    if (email.isNotEmpty) {
      await Purchases.setEmail(email);
    }
    if (name.isNotEmpty) {
      await Purchases.setDisplayName(name);
    }
  }

  @override
  Future<void> logOut() async {
    await Purchases.logOut();
  }

  @override
  Future<Paywall> getPaywall() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current == null) {
        throw StateError('No current offering');
      }

      return Paywall.fromRevenueCatOffering(current);
    } catch (e) {
      loggy.error('Error getting available products', e);
      rethrow;
    }
  }

  @override
  Future<void> restorePurchase() async {
    try {
      await Purchases.restorePurchases();
    } on PlatformException catch (e, s) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        // User canceled - return without rethrowing
        return;
      }

      loggy.error(
        'Restore purchase error: ${errorCode.name}. Please try again later.',
        e,
        s,
      );
      rethrow;
    }
  }

  @override
  Future<bool> purchase({
    required covariant RevenueCatPaywallProduct product,
  }) async {
    try {
      final storeProduct = product.package.storeProduct;
      await Purchases.purchaseStoreProduct(storeProduct);
      return true;
    } on PlatformException catch (e, s) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        // User canceled - return without rethrowing
        return false;
      }

      loggy.error(
        'Purchase error: ${errorCode.name}. Please try again later.',
        e,
        s,
      );
      rethrow;
    }
  }

  AppEntitlements _toAppEntitlements(CustomerInfo customerInfo) {
    final active = customerInfo.entitlements.active;

    return AppEntitlements(
      premium: active[_revenueCatPremiumEntitlement] != null,
    );
  }
}
