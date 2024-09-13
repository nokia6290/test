import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/app_config_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/model/app_config.dart';
import 'package:scalable_flutter_app_pro/feature/user/bloc/user_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserLoaded? _userLoadedState;
  ValueLoaded<AppConfig>? _appConfigLoadedState;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              _userLoadedState = state;
            }

            _onLoaded();
          },
        ),
        BlocListener<AppConfigCubit, ValueState<AppConfig>>(
          listener: (context, state) {
            if (state is ValueLoaded<AppConfig>) {
              _appConfigLoadedState = state;
            }

            _onLoaded();
          },
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(64),
          child: Center(
            child: Text(
              context.l10n.appName,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineLarge,
            ),
          ),
        ),
      ),
    );
  }

  void _onLoaded() {
    final userState = _userLoadedState;
    final appConfigState = _appConfigLoadedState;
    if (userState == null || appConfigState == null) {
      // Not loaded yet
      return;
    }

    final appConfig = appConfigState.value;
    if (!appConfig.isOnboardingComplete) {
      AppRoute.onboarding.go(context);
      return;
    }

    AppRoute.home.go(context);
  }
}
