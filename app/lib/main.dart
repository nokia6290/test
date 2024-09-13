import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:scalable_flutter_app_pro/core/app/app.dart';
import 'package:scalable_flutter_app_pro/core/provider/local_storage_provider.dart';
import 'package:scalable_flutter_app_pro/core/provider/remote_config_provider.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/provider/mixpanel_analytics_provider.dart';
import 'package:scalable_flutter_app_pro/feature/payment/provider/revenue_cat_provider.dart';
import 'package:scalable_flutter_app_pro/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(const ScalableFlutterApp());
}

Future<void> _init() async {
  await _initFirebase();
  _initLoggy();
  _initGoogleFonts();
  await _initHive();
  await _initLocalStorage();
  await _initPayment();
  await _initMixpanel();
}

void _initLoggy() {
  Loggy.initLoggy(
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.warning,
    ),
    logPrinter: const PrettyPrinter(),
  );
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    // Pass all uncaught errors to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Enable Crashlytics only in production
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  await RemoteConfigProvider.init();
}

void _initGoogleFonts() {
  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

Future<void> _initHive() async {
  await Hive.initFlutter();
}

Future<void> _initPayment() async {
  if (kIsWeb) {
    // RevenueCat is not supported on web
    return;
  }

  await RevenueCatProvider.init();
}

Future<void> _initLocalStorage() async {
  await LocalStorageProvider.init();
}

Future<void> _initMixpanel() async {
  await MixpanelAnalyticsProvider.init();
}
