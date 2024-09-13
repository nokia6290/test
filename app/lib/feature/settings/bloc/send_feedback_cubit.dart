import 'package:scalable_flutter_app_pro/core/bloc/single_action_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/repository/feedback_repository.dart';

class SendFeedbackCubit extends SingleActionCubit<SendFeedbackCubit> {
  SendFeedbackCubit({
    required this.feedbackRepository,
  });

  final FeedbackRepository feedbackRepository;

  void sendFeedback({
    required String email,
    required String message,
  }) {
    doAction(
      () => feedbackRepository.sendFeedback(
        email: email,
        message: message,
      ),
    );
  }
}
