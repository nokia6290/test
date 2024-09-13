import 'dart:async';

import 'package:scalable_flutter_app_pro/core/provider/local_storage_provider.dart';
import 'package:scalable_flutter_app_pro/core/provider/remote_config_provider.dart';
import 'package:scalable_flutter_app_pro/feature/settings/model/app_config.dart';

class AppConfigRepository {
  AppConfigRepository({
    required this.localStorageProvider,
    required this.remoteConfigProvider,
  }) {
    final appConfig = AppConfig(
      isOnboardingComplete: localStorageProvider.isOnboardingComplete,
      isDarkMode: localStorageProvider.isDarkMode,
      showAppReviewCard: remoteConfigProvider.showAppReviewCard,
    );

    _appConfig = appConfig;
    _appConfigStreamController.add(appConfig);
  }

  final LocalStorageProvider localStorageProvider;
  final RemoteConfigProvider remoteConfigProvider;

  final StreamController<AppConfig> _appConfigStreamController =
      StreamController<AppConfig>();

  Stream<AppConfig> get appConfigStream => _appConfigStreamController.stream;
  late AppConfig _appConfig;

  void close() {
    _appConfigStreamController.close();
  }

  void setOnboardingComplete({required bool complete}) {
    localStorageProvider.isOnboardingComplete = complete;
    _update((c) => c.copyWith(isOnboardingComplete: complete));
  }

  void setDarkMode({required bool darkMode}) {
    localStorageProvider.isDarkMode = darkMode;
    _update((c) => c.copyWith(isDarkMode: darkMode));
  }

  void _update(AppConfig Function(AppConfig c) update) {
    final appConfig = update(_appConfig);
    _appConfig = appConfig;
    _appConfigStreamController.add(appConfig);
  }
}
