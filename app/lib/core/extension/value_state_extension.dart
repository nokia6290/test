import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/core/exceptions/app_exception.dart';

extension ValueStateExt<T> on ValueState<T> {
  R when<R>({
    required R Function() initial,
    required R Function(T value) loaded,
    required R Function(AppException error) error,
  }) {
    return switch (this) {
      ValueInitial() => initial(),
      ValueLoaded(value: final value) => loaded(value),
      ValueError(error: final AppException e) => error(e),
    };
  }
}
