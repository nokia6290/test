import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/ui/input/image_picker_bottom_sheet.dart';

class PickedImage {
  const PickedImage({
    required this.filePath,
    required this.bytes,
  });

  final String filePath;
  final Uint8List bytes;
}

typedef LocalImageBuilder = Widget Function(
  BuildContext context,
  Uint8List bytes,
);

typedef NetworkImageBuilder = Widget Function(
  BuildContext context,
  String url,
);

class ImagePickerContainer extends StatelessWidget {
  const ImagePickerContainer({
    required this.networkImageUrl,
    required this.localBytes,
    required this.localImageBuilder,
    required this.networkImageBuilder,
    required this.onPicked,
    this.placeholderBuilder,
    super.key,
  });

  final String? networkImageUrl;
  final Uint8List? localBytes;
  final LocalImageBuilder localImageBuilder;
  final NetworkImageBuilder networkImageBuilder;
  final ValueChanged<PickedImage> onPicked;
  final WidgetBuilder? placeholderBuilder;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (localBytes != null) {
      child = localImageBuilder(context, localBytes!);
    } else if (networkImageUrl != null) {
      child = networkImageBuilder(context, networkImageUrl!);
    } else {
      child = placeholderBuilder?.call(context) ??
          ColoredBox(
            color: context.colorScheme.surface,
            child: const Icon(Icons.broken_image),
          );
    }

    return InkWell(
      onTap: () => _pickImage(context),
      child: child,
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage = await showModalBottomSheet<PickedImage?>(
      context: context,
      builder: (context) => const ImagePickerBottomSheet(),
    );

    if (pickedImage == null || !context.mounted) {
      return;
    }

    onPicked(pickedImage);
  }
}
