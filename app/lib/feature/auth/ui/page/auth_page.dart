import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/core/ui/dialog/dialogs.dart';
import 'package:scalable_flutter_app_pro/core/ui/input/input_field.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/labeled_text_button.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/loading_overlay.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/responsive.dart';
import 'package:scalable_flutter_app_pro/feature/auth/bloc/auth_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/auth/ui/widget/apple_auth_button.dart';
import 'package:scalable_flutter_app_pro/feature/auth/ui/widget/google_auth_button.dart';
import 'package:scalable_flutter_app_pro/feature/user/bloc/user_cubit.dart';

const toRoutePop = '_pop_';

class AuthPage extends StatefulWidget {
  const AuthPage({this.toRoute, super.key});

  final String? toRoute;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with UiLoggy {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSignUp = true;

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = context.isKeyboardVisible;
    final hasParentRoute = context.hasParentRoute;

    return BlocListener<UserCubit, UserState>(
      listener: _onUserState,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _onAuthState,
        builder: (context, state) {
          return LoadingOverlay(
            loading: state is AuthLoading,
            child: Scaffold(
              appBar: AppBar(
                leading: hasParentRoute
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => context.pop(),
                      )
                    : null,
              ),
              body: ConstrainedWidth.mobile(
                child: Form(
                  key: _formKey,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(),
                          Text(
                            _isSignUp
                                ? context.l10n.signUpTitle
                                : context.l10n.signInTitle,
                            style: context.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          InputField.email(
                            controller: _emailController,
                            label: context.l10n.email,
                          ),
                          const SizedBox(height: 16),
                          InputField.password(
                            controller: _passwordController,
                            label: context.l10n.password,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _submit,
                            child: Text(
                              _isSignUp
                                  ? context.l10n.signUp
                                  : context.l10n.signIn,
                            ),
                          ),
                          if (!isKeyboardVisible) ...[
                            const SizedBox(height: 8),
                            LabeledTextButton(
                              label: _isSignUp
                                  ? context.l10n.alreadyHaveAnAccount
                                  : context.l10n.dontHaveAnAccount,
                              action: _isSignUp
                                  ? context.l10n.signIn
                                  : context.l10n.signUp,
                              onTap: () =>
                                  setState(() => _isSignUp = !_isSignUp),
                            ),
                            LabeledTextButton(
                              action: context.l10n.forgotYourPassword,
                              onTap: () =>
                                  Dialogs.showForgotPasswordDialog(context),
                            ),
                            const SizedBox(height: 16),
                            GoogleAuthButton(
                              onPressed: () {
                                context.read<AuthCubit>().signInWithGoogle();
                              },
                            ),
                            if (Platform.isIOS)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: AppleAuthButton(
                                  onPressed: () {
                                    context.read<AuthCubit>().signInWithApple();
                                  },
                                ),
                              ),
                            const Spacer(),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showSnackBarMessage(
        state.exception.getText(context.l10n),
        isError: true,
      );
      return;
    }
  }

  void _onUserState(BuildContext context, UserState state) {
    if (state is! UserLoaded) {
      return;
    }

    if (state.user == null) {
      return;
    }

    final toRoute = widget.toRoute;
    if (toRoute == toRoutePop) {
      loggy.info('User loaded. Popping');
      context.pop(true);
      return;
    }

    if (toRoute != null) {
      loggy.info('User loaded. Going to: $toRoute');
      context.pushReplacement(toRoute);
      return;
    }

    loggy.info('User loaded. Going home.');
    AppRoute.home.go(context);
  }

  void _submit() {
    context.closeKeyboard();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_isSignUp) {
      context.read<AuthCubit>().signUpWithEmailAndPassword(
            email: email,
            password: password,
          );
    } else {
      context.read<AuthCubit>().signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    }
  }
}
