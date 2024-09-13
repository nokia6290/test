import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/app_entitlements_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/app_entitlements.dart';

extension BuildContextAppEntitlementsExt on BuildContext {
  AppEntitlements? get watchAppEntitlements {
    final state = watch<AppEntitlementsCubit>().state;
    if (state is! ValueLoaded<AppEntitlements>) {
      return null;
    }

    return state.value;
  }

  AppEntitlements? get getAppEntitlements {
    final state = read<AppEntitlementsCubit>().state;
    if (state is! ValueLoaded<AppEntitlements>) {
      return null;
    }

    return state.value;
  }
}
