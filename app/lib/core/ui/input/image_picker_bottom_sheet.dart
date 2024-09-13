import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/ui/dialog/dialogs.dart';
import 'package:scalable_flutter_app_pro/core/ui/input/image_picker_container.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              context.l10n.pickAnImage,
              style: context.textTheme.titleMedium,
            ),
          ),
          ListTile(
            title: Text(context.l10n.gallery),
            onTap: () => _pickImage(context, ImageSource.gallery),
          ),
          ListTile(
            title: Text(context.l10n.camera),
            onTap: () => _pickImage(context, ImageSource.camera),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);

    if (!context.mounted || file == null) {
      return;
    }

    final bytes = await file.readAsBytes();
    if (!context.mounted) {
      return;
    }

    final result = await Dialogs.showImageConfirmDialog(
      context,
      title: context.l10n.confirmTheImage,
      bytes: bytes,
    );

    if (result == null) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    context.pop(PickedImage(filePath: file.path, bytes: bytes));
  }
}
