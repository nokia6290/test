import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/value_stream_cubit.dart';
import 'package:scalable_flutter_app_pro/core/exceptions/app_exception.dart';
import 'package:scalable_flutter_app_pro/feature/payment/model/paywall.dart';
import 'package:scalable_flutter_app_pro/feature/payment/repository/payment_repository.dart';

class PaywallCubit extends Cubit<ValueState<Paywall>> {
  PaywallCubit({
    required this.paymentRepository,
  }) : super(const ValueInitial()) {
    _init();
  }

  final PaymentRepository paymentRepository;

  Future<void> _init() async {
    try {
      final paywall = await paymentRepository.getPaywall();
      emit(ValueLoaded(value: paywall));
    } catch (e, s) {
      emit(
        ValueError(
          error: AppException.createAndLog('_init', e, s),
        ),
      );
    }
  }
}
