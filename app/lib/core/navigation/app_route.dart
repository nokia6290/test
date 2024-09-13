import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  // Common
  splash('/', 'splash'),
  home('/home', 'home'),
  settings('/settings', 'settings'),
  auth('/auth', 'auth'),
  paywall('/paywall', 'paywall', isAuthProtected: true),
  onboarding('/onboarding', 'onboarding'),
  sendFeedback('/sendFeedback', 'sendFeedback'),

  // Articles
  articleAdd('/articleAdd', 'articleAdd', isAuthProtected: true),
  ;

  const AppRoute(
    this.path,
    this.name, {
    this.isAuthProtected = false,
  });

  factory AppRoute.fromPath(String path) {
    return AppRoute.values.firstWhere(
      (route) => route.path == path,
    );
  }

  final String path;
  final String name;
  final bool isAuthProtected;
}

extension AppRouteNavigation on AppRoute {
  void go(
    BuildContext context, {
    Map<String, dynamic> params = const {},
  }) =>
      context.goNamed(
        name,
        queryParameters: {
          ...params,
          if (isAuthProtected) 'toRoute': path,
        },
      );

  void push(
    BuildContext context, {
    Map<String, dynamic> params = const {},
  }) =>
      context.pushNamed(
        name,
        queryParameters: {
          ...params,
          if (isAuthProtected) 'toRoute': path,
        },
      );
}
