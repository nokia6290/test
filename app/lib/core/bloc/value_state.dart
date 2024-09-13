part of 'value_stream_cubit.dart';

@immutable
sealed class ValueState<T> {
  const ValueState();
}

class ValueInitial<T> extends ValueState<T> {
  const ValueInitial();
}

class ValueLoaded<T> extends ValueState<T> {
  const ValueLoaded({required this.value});

  final T value;
}

class ValueError<T> extends ValueState<T> {
  const ValueError({required this.error});

  final AppException error;
}
