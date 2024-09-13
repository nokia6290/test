import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    required this.title,
    required this.content,
    this.action,
    super.key,
  });

  final String title;
  final Widget content;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            content,
            if (action != null) ...[
              const SizedBox(height: 8),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [action!],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
