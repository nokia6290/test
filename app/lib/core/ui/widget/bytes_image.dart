import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/url_image.dart';

class BytesImage extends StatelessWidget {
  const BytesImage({
    required this.bytes,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    super.key,
  }) : shape = ImageShape.rectangle;

  const BytesImage.square({
    required this.bytes,
    required double size,
    this.fit = BoxFit.cover,
    super.key,
  })  : width = size,
        height = size,
        shape = ImageShape.rectangle;

  const BytesImage.circle({
    required this.bytes,
    required double size,
    this.fit = BoxFit.cover,
    super.key,
  })  : width = size,
        height = size,
        shape = ImageShape.circle;

  final Uint8List bytes;
  final double width;
  final double height;
  final ImageShape shape;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final image = bytes.isEmpty
        ? Container(
            width: width,
            height: height,
            color: context.colorScheme.surface,
            child: const Icon(Icons.broken_image),
          )
        : Image.memory(
            bytes,
            width: width,
            height: height,
            fit: fit,
          );

    return switch (shape) {
      ImageShape.circle => ClipOval(child: image),
      ImageShape.rectangle => image,
    };
  }
}
