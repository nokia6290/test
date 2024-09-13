import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/provider/base_analytics_provider.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

const _mixpanelToken = 'YOUR_MIXPANEL_TOKEN';

class MixpanelAnalyticsProvider extends BaseAnalyticsProvider {
  static late final Mixpanel _mixpanel;

  static Future<void> init() async {
    _mixpanel = await Mixpanel.init(
      _mixpanelToken,
      trackAutomaticEvents: true,
    );

    // Uncomment to track only in release
    // if (!kReleaseMode) {
    //   await _mixpanel.flush();
    //   _mixpanel.optOutTracking();
    // }
  }

  @override
  void setUser(User user) {
    _mixpanel.identify(user.id);
    _mixpanel.getPeople()
      ..set('Name', user.name)
      ..set('Email', user.email);
  }

  @override
  void onSignOut() {
    _mixpanel
      ..track('Sign Out')
      ..reset();
  }

  @override
  void logSignIn({required AuthMethod method}) {
    _mixpanel.track(
      'Sign In',
      properties: {
        'Method': method.id,
      },
    );
  }

  @override
  void logSignUp({required AuthMethod method}) {
    _mixpanel.track(
      'Sign Up',
      properties: {
        'Method': method.id,
      },
    );
  }

  @override
  void logArticleAdded() {
    _mixpanel.track('Article Added');
  }
}
