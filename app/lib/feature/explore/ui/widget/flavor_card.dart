import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/app/flavor.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/explore_card.dart';

class FlavorCard extends StatelessWidget {
  const FlavorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = Flavor();

    return ExploreCard(
      title: 'Flavor',
      content: Text(flavor.name),
    );
  }
}
