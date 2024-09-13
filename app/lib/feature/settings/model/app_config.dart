class AppConfig {
  const AppConfig({
    required this.isOnboardingComplete,
    required this.isDarkMode,
    required this.showAppReviewCard,
  });

  final bool isOnboardingComplete;
  final bool isDarkMode;
  final bool showAppReviewCard;

  AppConfig copyWith({
    bool? isOnboardingComplete,
    bool? isDarkMode,
    bool? showAppReviewCard,
  }) {
    return AppConfig(
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      showAppReviewCard: showAppReviewCard ?? this.showAppReviewCard,
    );
  }
}
