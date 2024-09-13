import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:scalable_flutter_app_pro/core/app/di.dart';
import 'package:scalable_flutter_app_pro/core/app/style.dart';
import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/navigation/router.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/app_config_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/model/app_config.dart';

class ScalableFlutterApp extends StatelessWidget {
  const ScalableFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DI(child: _App());
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  late GoRouter _router;

  @override
  void initState() {
    final analyticsRepository = context.read<AnalyticsRepository>();
    final observers = analyticsRepository.getObservers();
    _router = getRouter(observers: observers);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.select<AppConfigCubit, bool>((cubit) {
      final state = cubit.state;
      if (state is ValueLoaded<AppConfig>) {
        return state.value.isDarkMode;
      }

      return false;
    });

    return KeyboardVisibilityProvider(
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.l10n.appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
