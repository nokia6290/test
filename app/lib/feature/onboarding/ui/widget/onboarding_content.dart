import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/responsive.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    required this.title,
    required this.image,
    super.key,
  });

  final String title;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge,
          ),
          const Spacer(),
          ConstrainedWidth.mobile(
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: image,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
