part of 'connectivity_cubit.dart';

@immutable
sealed class ConnectivityState {
  const ConnectivityState();
}

class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial();
}

class ConnectivityLoaded extends ConnectivityState {
  const ConnectivityLoaded({
    required this.connectivityResult,
  });

  final ConnectivityResult connectivityResult;
}
