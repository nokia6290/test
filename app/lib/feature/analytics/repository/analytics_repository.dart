import 'package:flutter/widgets.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/provider/base_analytics_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

enum AuthMethod {
  emailAndPassword('email-and-password'),
  google('google'),
  apple('apple'),
  ;

  const AuthMethod(this.id);

  final String id;
}

class AnalyticsRepository extends BaseAnalyticsProvider with RepositoryLoggy {
  const AnalyticsRepository({
    required this.providers,
  });

  final List<BaseAnalyticsProvider> providers;

  @override
  List<NavigatorObserver> getObservers() {
    return [
      for (final provider in providers) ...provider.getObservers(),
    ];
  }

  @override
  void setUser(User user) {
    _all((p) => p.setUser(user));
  }

  @override
  void onSignOut() {
    _all((p) => p.onSignOut());
  }

  @override
  void logSignIn({required AuthMethod method}) {
    _all((p) => p.logSignIn(method: method));
  }

  @override
  void logSignUp({required AuthMethod method}) {
    _all((p) => p.logSignUp(method: method));
  }

  @override
  void logArticleAdded() {
    _all((p) => p.logArticleAdded());
  }

  void _all(void Function(BaseAnalyticsProvider p) action) {
    providers.forEach(action);
  }
}
