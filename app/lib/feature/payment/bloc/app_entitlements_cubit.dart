import 'dart:async';

import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/app_entitlements.dart';
import 'package:scalable_flutter_app_pro/feature/payment/repository/payment_repository.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';
import 'package:scalable_flutter_app_pro/feature/user/repository/user_repository.dart';

class AppEntitlementsCubit extends ValueStreamCubit<AppEntitlements> {
  AppEntitlementsCubit({
    required this.paymentRepository,
    required this.userRepository,
  }) {
    _userSubscription =
        userRepository.getUserStream().listen(paymentRepository.setUser);
  }

  StreamSubscription<User?>? _userSubscription;

  final PaymentRepository paymentRepository;
  final UserRepository userRepository;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    paymentRepository.close();
    return super.close();
  }

  @override
  Stream<AppEntitlements> getValueStream() =>
      paymentRepository.appEntitlementsStream;
}
