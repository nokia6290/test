import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/single_action_cubit.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_user.dart';
import 'package:scalable_flutter_app_pro/core/ui/input/image_picker_container.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/bytes_image.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/item/single_action_bloc_listener.dart';
import 'package:scalable_flutter_app_pro/feature/user/bloc/upload_user_image_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/user/repository/user_repository.dart';
import 'package:scalable_flutter_app_pro/feature/user/ui/widget/user_image.dart';

class UserImagePickerContainer extends StatefulWidget {
  const UserImagePickerContainer({super.key});

  @override
  State<UserImagePickerContainer> createState() =>
      _UserImagePickerContainerState();
}

class _UserImagePickerContainerState extends State<UserImagePickerContainer> {
  Uint8List? _localBytes;

  @override
  Widget build(BuildContext context) {
    final user = context.watchCurrentUser;
    if (user == null) {
      return const SizedBox();
    }

    return BlocProvider<UploadUserImageCubit>(
      create: (context) => UploadUserImageCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: BlocBuilder<UploadUserImageCubit,
          SingleActionState<UploadUserImageCubit>>(
        builder: (context, state) {
          return SingleActionBlocListener<UploadUserImageCubit>(
            onSuccess: () {
              context.showSnackBarMessage(context.l10n.imageSaved);
            },
            child: ImagePickerContainer(
              networkImageUrl: user.imageUrl,
              localBytes: _localBytes,
              localImageBuilder: (context, bytes) => BytesImage.circle(
                bytes: bytes,
                size: 48,
              ),
              networkImageBuilder: (context, url) => UserImage.medium(url),
              onPicked: (pickedImage) {
                setState(() => _localBytes = pickedImage.bytes);
                context.read<UploadUserImageCubit>().upload(
                      bytes: pickedImage.bytes,
                      filePath: pickedImage.filePath,
                      userId: context.getCurrentUser!.id,
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
