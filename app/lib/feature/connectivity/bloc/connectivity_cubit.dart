import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityInitial()) {
    _init();
  }

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }

  void _init() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      emit(ConnectivityLoaded(connectivityResult: result));
    });
  }
}
