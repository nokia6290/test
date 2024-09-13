import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.current,
    required this.total,
    super.key,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < total; i++)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: i == current
                  ? context.colorScheme.primary
                  : context.colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
