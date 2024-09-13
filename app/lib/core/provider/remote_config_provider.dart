import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

const _keyShowAppReviewCard = 'show_app_review_card';

class RemoteConfigProvider {
  static late final FirebaseRemoteConfig _remoteConfig;

  static Future<void> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: kReleaseMode
            ? const Duration(hours: 1)
            : const Duration(minutes: 5),
      ),
    );
    await remoteConfig.setDefaults(const {
      _keyShowAppReviewCard: false,
    });
    await remoteConfig.fetchAndActivate();

    _remoteConfig = remoteConfig;
  }

  bool get showAppReviewCard => _getBool(_keyShowAppReviewCard);

  bool _getBool(String key) => _remoteConfig.getBool(key);
}
