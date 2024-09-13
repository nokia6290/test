import 'dart:typed_data';

import 'package:scalable_flutter_app_pro/core/bloc/single_action_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/user/repository/user_repository.dart';

class UploadUserImageCubit extends SingleActionCubit<UploadUserImageCubit> {
  UploadUserImageCubit({
    required this.userRepository,
  });

  final UserRepository userRepository;

  void upload({
    required Uint8List bytes,
    required String filePath,
    required String userId,
  }) {
    doAction(
      () => userRepository.uploadPhoto(
        userId: userId,
        filePath: filePath,
        bytes: bytes,
      ),
    );
  }
}
