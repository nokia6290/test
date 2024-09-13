import 'package:shared_preferences/shared_preferences.dart';

const _keyOnboardingComplete = 'onboarding_complete';
const _keyDarkMode = 'dark_mode';

class LocalStorageProvider {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isOnboardingComplete => _getBool(_keyOnboardingComplete);

  set isOnboardingComplete(bool value) =>
      _setBool(_keyOnboardingComplete, value);

  bool get isDarkMode => _getBool(_keyDarkMode);

  set isDarkMode(bool value) => _setBool(_keyDarkMode, value);

  void _setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  bool _getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }
}
