import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_user.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/feature/user/ui/widget/user_image_picker_container.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watchCurrentUser;
    final Widget content;

    if (user == null) {
      content = Center(
        child: ElevatedButton(
          onPressed: () => AppRoute.auth.push(context),
          child: Text(context.l10n.signIn),
        ),
      );
    } else {
      content = Center(
        child: Column(
          children: [
            const UserImagePickerContainer(),
            const SizedBox(height: 16),
            if (user.name.isNotEmpty) ...[
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
            ],
            Text(
              user.email,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => AppRoute.settings.push(context),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: content,
    );
  }
}
