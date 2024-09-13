import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/page_indicator.dart';
import 'package:scalable_flutter_app_pro/feature/onboarding/ui/widget/onboarding_content.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/app_config_cubit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final onboardingPages = <Widget>[
      OnboardingContent(
        title: context.l10n.onboardingTitle1,
        image: const Icon(
          Icons.rocket_launch,
          size: 160,
        ),
      ),
      OnboardingContent(
        title: context.l10n.onboardingTitle2,
        image: const Icon(
          Icons.calendar_month,
          size: 160,
        ),
      ),
      OnboardingContent(
        title: context.l10n.onboardingTitle3,
        image: const Icon(
          Icons.new_releases,
          size: 160,
        ),
      ),
    ];

    final pageCount = onboardingPages.length;
    final isLastPage = _currentPage == pageCount - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: onboardingPages,
                onPageChanged: (page) => setState(() => _currentPage = page),
              ),
            ),
            Center(
              child: PageIndicator(
                current: _currentPage,
                total: pageCount,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => _onContinue(isLastPage),
                child: Text(context.l10n.actionContinue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinue(bool isLastPage) {
    if (!isLastPage) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    context.read<AppConfigCubit>().setOnboardingComplete(complete: true);
    AppRoute.home.go(context);
  }
}
