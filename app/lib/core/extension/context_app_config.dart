import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/app_config_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/model/app_config.dart';

extension BuildContextAppConfigsExt on BuildContext {
  AppConfig? get watchAppConfig {
    final state = watch<AppConfigCubit>().state;
    if (state is! ValueLoaded<AppConfig>) {
      return null;
    }

    return state.value;
  }

  AppConfig? get getAppConfig {
    final state = read<AppConfigCubit>().state;
    if (state is! ValueLoaded<AppConfig>) {
      return null;
    }

    return state.value;
  }
}
