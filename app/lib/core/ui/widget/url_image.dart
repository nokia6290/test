import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';

enum ImageShape {
  circle,
  rectangle,
}

class UrlImage extends StatelessWidget {
  const UrlImage({
    required this.url,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    super.key,
  }) : shape = ImageShape.rectangle;

  const UrlImage.square({
    required this.url,
    required double size,
    this.fit = BoxFit.cover,
    super.key,
  })  : width = size,
        height = size,
        shape = ImageShape.rectangle;

  const UrlImage.circle({
    required this.url,
    required double size,
    this.fit = BoxFit.cover,
    super.key,
  })  : width = size,
        height = size,
        shape = ImageShape.circle;

  final String url;
  final double width;
  final double height;
  final ImageShape shape;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final image = url.isEmpty
        ? Container(
            width: width,
            height: height,
            color: context.colorScheme.surface,
            child: const Icon(Icons.broken_image),
          )
        : CachedNetworkImage(
            imageUrl: url,
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
