import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_user.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/article/bloc/article_add_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/article/bloc/articles_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/article/repository/article_repository.dart';
import 'package:scalable_flutter_app_pro/feature/article/ui/page/article_add_page.dart';
import 'package:scalable_flutter_app_pro/feature/auth/bloc/auth_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/auth/repository/auth_repository.dart';
import 'package:scalable_flutter_app_pro/feature/auth/ui/page/auth_page.dart';
import 'package:scalable_flutter_app_pro/feature/auth/ui/page/splash_page.dart';
import 'package:scalable_flutter_app_pro/feature/home/ui/page/home_page.dart';
import 'package:scalable_flutter_app_pro/feature/onboarding/ui/page/onboarding_page.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/paywall_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/purchase_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/repository/payment_repository.dart';
import 'package:scalable_flutter_app_pro/feature/payment/ui/page/paywall_page.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/send_feedback_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/repository/feedback_repository.dart';
import 'package:scalable_flutter_app_pro/feature/settings/ui/page/send_feedback_page.dart';
import 'package:scalable_flutter_app_pro/feature/settings/ui/page/settings_page.dart';

GoRouter getRouter({
  required List<NavigatorObserver> observers,
}) {
  return GoRouter(
    redirect: (context, state) {
      final path = state.fullPath ?? AppRoute.splash.path;

      if (path == AppRoute.splash.path) {
        // Don't redirect from splash page
        return null;
      }

      final user = context.getCurrentUser;
      if (user != null) {
        // Don't redirect if user is already logged in
        return null;
      }

      final appRoute = AppRoute.fromPath(path);
      if (appRoute.isAuthProtected) {
        // Redirect to auth page from a protected page.
        return Uri(
          path: AppRoute.auth.path,
          queryParameters: state.uri.queryParameters,
        ).toString();
      }

      // Uncomment this to ALWAYS redirect to auth page if user isn't logged in.
      // WARNING: Apple App Store highly discourages forcing users to sign in
      // before they can use the app. This might get your app rejected.
      // return AppRoute.auth.path;
      return null;
    },
    observers: observers,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => BlocProvider(
          create: (context) => ArticlesCubit(
            articleRepository: context.read<ArticleRepository>(),
          ),
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        builder: (context, state) {
          final encodedToRoute = state.uri.queryParameters['toRoute'];
          final toRoute = encodedToRoute != null
              ? Uri.decodeQueryComponent(encodedToRoute)
              : null;

          return BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              analyticsRepository: context.read<AnalyticsRepository>(),
            ),
            child: AuthPage(
              toRoute: toRoute,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoute.articleAdd.path,
        name: AppRoute.articleAdd.name,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ArticleAddCubit(
              articleRepository: context.read<ArticleRepository>(),
              analyticsRepository: context.read<AnalyticsRepository>(),
            ),
            child: const ArticleAddPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoute.paywall.path,
        name: AppRoute.paywall.name,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PaywallCubit(
                paymentRepository: context.read<PaymentRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => PurchaseCubit(
                paymentRepository: context.read<PaymentRepository>(),
              ),
            ),
          ],
          child: const PaywallPage(),
        ),
      ),
      GoRoute(
        path: AppRoute.sendFeedback.path,
        name: AppRoute.sendFeedback.name,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SendFeedbackCubit(
              feedbackRepository: context.read<FeedbackRepository>(),
            ),
            child: const SendFeedbackPage(),
          );
        },
      ),
    ],
  );
}
