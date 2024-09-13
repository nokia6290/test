import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:scalable_flutter_app_pro/core/app/constants.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/explore_card.dart';

class AppReviewCard extends StatelessWidget {
  const AppReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExploreCard(
      title: context.l10n.appReviewTitle,
      content: Text(context.l10n.appReviewDescription),
      action: ElevatedButton(
        onPressed: () => InAppReview.instance.openStoreListing(
          appStoreId: Constants.appStoreId,
        ),
        child: Text(context.l10n.leaveYourReview),
      ),
    );
  }
}
