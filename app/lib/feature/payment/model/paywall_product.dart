import 'package:purchases_flutter/purchases_flutter.dart';

sealed class PaywallProduct {
  const PaywallProduct({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final String price;
}

class RevenueCatPaywallProduct extends PaywallProduct {
  RevenueCatPaywallProduct(this.package)
      : super(
          id: package.identifier,
          name: package.storeProduct.title,
          price: package.storeProduct.priceString,
        );

  final Package package;
}

class MockPaywallProduct extends PaywallProduct {
  const MockPaywallProduct({
    required super.id,
    required super.name,
    required super.price,
  });
}
