import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/repository/notifications_repository.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';
import 'package:scalable_flutter_app_pro/feature/user/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> with BlocLoggy {
  UserCubit({
    required this.userRepository,
    required this.analyticsRepository,
    required this.notificationsRepository,
  }) : super(const UserInitial()) {
    _load();
  }

  final UserRepository userRepository;
  final AnalyticsRepository analyticsRepository;
  final NotificationsRepository notificationsRepository;

  StreamSubscription<User?>? _userSubscription;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> logOut() async {
    analyticsRepository.onSignOut();
    await notificationsRepository.removeFcmToken();
    await userRepository.logOut();
  }

  void _load() {
    _userSubscription = userRepository.getUserStream().listen(_onUser);
  }

  void _onUser(User? user) {
    loggy.info('new user: ${user?.id}');
    emit(UserLoaded(user: user));

    if (user != null) {
      notificationsRepository.addFcmToken();
      analyticsRepository.setUser(user);
    }
  }
}
