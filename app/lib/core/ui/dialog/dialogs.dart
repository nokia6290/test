import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/core/ui/dialog/confirmation_dialog.dart';
import 'package:scalable_flutter_app_pro/core/ui/input/image_confirm_dialog.dart';
import 'package:scalable_flutter_app_pro/feature/auth/bloc/auth_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/auth/ui/widget/forgot_password_dialog.dart';
import 'package:scalable_flutter_app_pro/feature/user/bloc/user_cubit.dart';

sealed class Dialogs {
  const Dialogs._();

  static Future<void> showDeleteAccountConfirmationDialog(
    BuildContext context,
  ) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: context.l10n.deleteMyAccount,
      message: context.l10n.deleteMyAccountConfirmation,
      confirmText: context.l10n.deleteMyAccount,
      isDestructive: true,
    );

    if (confirmed && context.mounted) {
      // TODO: implement delete account
      context.showSnackBarMessage(context.l10n.requestSubmitted);
    }
  }

  static Future<void> showLogOutConfirmationDialog(
    BuildContext context,
  ) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: context.l10n.signOut,
      message: context.l10n.signOutConfirmation,
      confirmText: context.l10n.signOut,
      isDestructive: true,
    );

    if (confirmed && context.mounted) {
      await context.read<UserCubit>().logOut();

      if (context.mounted) {
        AppRoute.home.go(context);
      }
    }
  }

  static Future<void> showForgotPasswordDialog(BuildContext context) async {
    final email = await showDialog<String>(
      context: context,
      builder: (context) => ForgotPasswordDialog(),
    );

    if (!context.mounted) {
      return;
    }

    if (email == null) {
      return;
    }

    final result = await context.read<AuthCubit>().resetPassword(email);
    if (!context.mounted) {
      return;
    }

    if (result) {
      context.showSnackBarMessage(context.l10n.resetPasswordEmailSent);
    }
  }

  static Future<Uint8List?> showImageConfirmDialog(
    BuildContext context, {
    required String title,
    required Uint8List bytes,
  }) async {
    return showDialog<Uint8List>(
      context: context,
      builder: (context) => ImageConfirmDialog(
        title: title,
        bytes: bytes,
      ),
    );
  }

  static Future<bool> _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    bool isDestructive = false,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: title,
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
          ),
        ) ??
        false;
  }
}
