import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_app_config.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_user.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/core/ui/dialog/dialogs.dart';
import 'package:scalable_flutter_app_pro/core/util/urls.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/app_config_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/settings/ui/widget/app_version.dart';
import 'package:scalable_flutter_app_pro/feature/settings/ui/widget/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watchCurrentUser;
    final appConfig = context.watchAppConfig;
    final isDarkMode = appConfig?.isDarkMode ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SettingsTile.toggle(
              icon: const Icon(Icons.dark_mode_outlined),
              label: context.l10n.darkMode,
              isOn: isDarkMode,
              onChanged: (value) => context.read<AppConfigCubit>().setDarkMode(
                    darkMode: value,
                  ),
            ),
            SettingsTile(
              icon: const Icon(Icons.feedback_outlined),
              label: context.l10n.sendFeedback,
              onTap: () => AppRoute.sendFeedback.push(context),
            ),
            const Divider(),
            SettingsTile(
              icon: const Icon(Icons.security_outlined),
              label: context.l10n.privacyPolicy,
              onTap: Urls.showPrivacyPolicy,
            ),
            SettingsTile(
              icon: const Icon(Icons.fact_check_outlined),
              label: context.l10n.termsOfService,
              onTap: Urls.showTermsOfService,
            ),
            if (user != null) ...[
              const Divider(),
              SettingsTile(
                icon: const Icon(Icons.delete_outlined),
                label: context.l10n.deleteMyAccount,
                isDestructive: true,
                onTap: () =>
                    Dialogs.showDeleteAccountConfirmationDialog(context),
              ),
              SettingsTile(
                icon: const Icon(Icons.logout_outlined),
                label: context.l10n.signOut,
                onTap: () => Dialogs.showLogOutConfirmationDialog(context),
              ),
            ],
            const Padding(
              padding: EdgeInsets.all(32),
              child: AppVersion(),
            ),
          ],
        ),
      ),
    );
  }
}
