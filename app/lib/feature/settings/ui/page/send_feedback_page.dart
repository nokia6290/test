import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/extension/context_user.dart';
import 'package:scalable_flutter_app_pro/core/ui/input/input_field.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/item/single_action_bloc_listener.dart';
import 'package:scalable_flutter_app_pro/feature/settings/bloc/send_feedback_cubit.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _userEmail;

  @override
  void initState() {
    final email = context.getCurrentUser?.email;
    if (email != null && email.isNotEmpty) {
      _userEmail = email;
      _emailController.text = email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleActionBlocListener<SendFeedbackCubit>(
      onSuccess: () => context
        ..showSnackBarMessage(context.l10n.success)
        ..pop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.sendFeedback),
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_userEmail == null) ...[
                    InputField.email(
                      controller: _emailController,
                      label: context.l10n.email,
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                  InputField.multiline(
                    controller: _messageController,
                    label: context.l10n.text,
                    autofocus: _userEmail != null,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _send,
                    child: Text(context.l10n.send),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _send() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _userEmail ?? _emailController.text.trim();
    final message = _messageController.text.trim();

    context.read<SendFeedbackCubit>().sendFeedback(
          email: email,
          message: message,
        );
  }
}
