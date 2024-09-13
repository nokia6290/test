import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/provider/base_analytics_provider.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

class FirebaseAnalyticsProvider extends BaseAnalyticsProvider
    with ProviderLoggy {
  final _analytics = FirebaseAnalytics.instance;

  @override
  List<NavigatorObserver> getObservers() {
    return [
      FirebaseAnalyticsObserver(analytics: _analytics),
    ];
  }

  @override
  void setUser(User user) {
    _analytics
      ..setUserId(id: user.id)
      ..setUserProperty(name: 'name', value: user.name)
      ..setUserProperty(name: 'email', value: user.email);
  }

  @override
  void onSignOut() {
    _analytics.setUserId(id: null);
  }

  @override
  void logSignIn({required AuthMethod method}) {
    _analytics.logLogin(loginMethod: method.id);
  }

  @override
  void logSignUp({required AuthMethod method}) {
    _analytics.logSignUp(signUpMethod: method.id);
  }

  @override
  void logArticleAdded() {
    _analytics.logEvent(name: 'article_added');
  }
}
