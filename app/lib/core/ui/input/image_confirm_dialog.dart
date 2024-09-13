import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';

class ImageConfirmDialog extends StatelessWidget {
  const ImageConfirmDialog({
    required this.title,
    required this.bytes,
    super.key,
  });

  final String title;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: AspectRatio(
        aspectRatio: 1,
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.onBackground,
          ),
          onPressed: () => context.pop(),
          child: Text(context.l10n.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(bytes),
          child: Text(context.l10n.confirm),
        ),
      ],
    );
  }
}
