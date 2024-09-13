import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/exceptions/app_exception.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';

part 'value_state.dart';

/// Common Cubit to listen to items.
abstract class ValueStreamCubit<T> extends Cubit<ValueState<T>> with BlocLoggy {
  ValueStreamCubit() : super(const ValueInitial()) {
    unawaited(_load());
  }

  StreamSubscription<T>? _itemsSubscription;

  @override
  Future<void> close() async {
    await _itemsSubscription?.cancel();
    await super.close();
  }

  @protected
  Stream<T> getValueStream();

  Future<void> _load() async {
    await _itemsSubscription?.cancel();
    emit(const ValueInitial());

    try {
      _itemsSubscription = getValueStream().listen((value) {
        emit(ValueLoaded(value: value));
      });
    } catch (e, s) {
      final exception = AppException.createAndLog(
        '_load',
        e,
        s,
      );
      emit(ValueError(error: exception));
    }
  }
}
