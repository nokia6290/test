import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/provider/item_provider.dart';
import 'package:scalable_flutter_app_pro/core/provider/local_storage_provider.dart';
import 'package:scalable_flutter_app_pro/core/provider/remote_config_provider.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/provider/firebase_analytics_provider.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/provider/mixpanel_analytics_provider.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/article/provider/article_dio_provider.dart';
import 'package:scalable_flutter_app_pro/feature/article/provider/article_firestore_provider.dart';
import 'package:scalable_flutter_app_pro/feature/article/provider/article_hive_box_provider.dart';
import 'package:scalable_flutter_app_pro/feature/article/repository/article_repository.dart';
import 'package:scalable_flutter_app_pro/feature/auth/provider/auth_provider.dart';
import 'package:scalable_flutter_app_pro/feature/auth/provider/firebase_auth_provider.dart';
import 'package:scalable_flutter_app_pro/feature/auth/repository/auth_repository.dart';
import 'package:scalable_flutter_app_pro/feature/connectivity/bloc/connectivity_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/bloc/notifications_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/provider/firebase_notifications_provider.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/provider/local_notifications_provider.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/repository/notifications_repository.dart';
import 'package:scalable_flutter_app_pro/feature/payment/bloc/app_entitlements_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/payment/provider/mock_paywall_provider.dart';
import 'package:scalable_flutter_app_pro/feature/payment/provider/paywall_provider.dart';
import 'package:scalable_flutter_app_pro/feature/payment/repository/payment_repository.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/app_config_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/repository/app_config_repository.dart';
import 'package:scalable_flutter_app_pro/feature/settings/repository/feedback_repository.dart';
import 'package:scalable_flutter_app_pro/feature/storage/provider/firebase_storage_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/bloc/user_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';
import 'package:scalable_flutter_app_pro/feature/user/provider/user_cloud_functions_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/provider/user_firestore_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/repository/user_repository.dart';

class DI extends StatelessWidget {
  const DI({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ProviderDI(
      child: _RepositoryDI(
        child: _BlocDI(
          child: child,
        ),
      ),
    );
  }
}

class _ProviderDI extends StatelessWidget {
  const _ProviderDI({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthProvider>(
          create: (context) => FirebaseAuthProvider(),
        ),
        RepositoryProvider<FirebaseAnalyticsProvider>(
          create: (context) => FirebaseAnalyticsProvider(),
        ),
        RepositoryProvider<ItemProvider<User>>(
          create: (context) => const UserFirestoreProvider(),
        ),
        RepositoryProvider<ArticleFirestoreProvider>(
          create: (context) => const ArticleFirestoreProvider(),
        ),
        RepositoryProvider<ArticleHiveBoxProvider>(
          create: (context) => ArticleHiveBoxProvider(),
        ),
        RepositoryProvider<PaywallProvider>(
          create: (context) => MockPaywallProvider(),
          // FIXME: use RevenueCatProvider after integration
          // create: (context) =>
          //     kIsWeb ? MockPaywallProvider() : RevenueCatProvider(),
        ),
        RepositoryProvider<LocalStorageProvider>(
          create: (context) => LocalStorageProvider(),
        ),
        RepositoryProvider<RemoteConfigProvider>(
          create: (context) => RemoteConfigProvider(),
        ),
        RepositoryProvider<MixpanelAnalyticsProvider>(
          create: (context) => MixpanelAnalyticsProvider(),
        ),
        RepositoryProvider<FirebaseStorageProvider>(
          create: (context) => FirebaseStorageProvider(),
        ),
        RepositoryProvider<LocalNotificationsProvider>(
          create: (context) => LocalNotificationsProvider(),
        ),
        RepositoryProvider<UserCloudFunctionsProvider>(
          create: (context) => UserCloudFunctionsProvider(),
        ),
        RepositoryProvider<FirebaseNotificationsProvider>(
          create: (context) => FirebaseNotificationsProvider(),
        ),
        RepositoryProvider<ArticleDioProvider>(
          create: (context) => ArticleDioProvider(),
        ),
      ],
      child: child,
    );
  }
}

class _RepositoryDI extends StatelessWidget {
  const _RepositoryDI({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            userProvider: context.read<ItemProvider<User>>(),
            authProvider: context.read<AuthProvider>(),
            storageProvider: context.read<FirebaseStorageProvider>(),
            cloudFunctions: context.read<UserCloudFunctionsProvider>(),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            authProvider: context.read<AuthProvider>(),
          ),
        ),
        RepositoryProvider<AnalyticsRepository>(
          create: (context) => AnalyticsRepository(
            providers: [
              context.read<FirebaseAnalyticsProvider>(),
              context.read<MixpanelAnalyticsProvider>(),
            ],
          ),
        ),
        RepositoryProvider<ArticleRepository>(
          create: (context) => ArticleRepository(
            remoteProvider: context.read<ArticleFirestoreProvider>(),
            localProvider: context.read<ArticleHiveBoxProvider>(),
            httpProvider: context.read<ArticleDioProvider>(),
          ),
        ),
        RepositoryProvider<PaymentRepository>(
          create: (context) => PaymentRepository(
            paywallProvider: context.read<PaywallProvider>(),
          ),
        ),
        RepositoryProvider<AppConfigRepository>(
          create: (context) => AppConfigRepository(
            localStorageProvider: context.read<LocalStorageProvider>(),
            remoteConfigProvider: context.read<RemoteConfigProvider>(),
          ),
        ),
        RepositoryProvider<FeedbackRepository>(
          create: (context) => FeedbackRepository(),
        ),
        RepositoryProvider<NotificationsRepository>(
          create: (context) => NotificationsRepository(
            localNotificationsProvider:
                context.read<LocalNotificationsProvider>(),
            firebaseNotificationsProvider:
                context.read<FirebaseNotificationsProvider>(),
            cloudFunctions: context.read<UserCloudFunctionsProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}

class _BlocDI extends StatelessWidget {
  const _BlocDI({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            userRepository: context.read<UserRepository>(),
            analyticsRepository: context.read<AnalyticsRepository>(),
            notificationsRepository: context.read<NotificationsRepository>(),
          ),
        ),
        BlocProvider<ConnectivityCubit>(
          create: (context) => ConnectivityCubit(),
        ),
        BlocProvider<AppEntitlementsCubit>(
          create: (context) => AppEntitlementsCubit(
            paymentRepository: context.read<PaymentRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider<AppConfigCubit>(
          create: (context) => AppConfigCubit(
            appConfigRepository: context.read<AppConfigRepository>(),
          ),
        ),
        BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(
            notificationsRepository: context.read<NotificationsRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
