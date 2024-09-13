import 'package:flutter/widgets.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

abstract class BaseAnalyticsProvider {
  const BaseAnalyticsProvider();

  List<NavigatorObserver> getObservers() => const [];

  void setUser(User user);

  void onSignOut();

  void logSignUp({required AuthMethod method});

  void logSignIn({required AuthMethod method});

  void logArticleAdded();
}
