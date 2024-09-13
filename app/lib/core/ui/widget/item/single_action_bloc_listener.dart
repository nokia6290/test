import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/single_action_cubit.dart';
import 'package:scalable_flutter_app_pro/core/exceptions/app_exception.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/loading_overlay.dart';

class SingleActionBlocListener<T extends SingleActionCubit<T>>
    extends StatelessWidget {
  const SingleActionBlocListener({
    required this.onSuccess,
    required this.child,
    this.onError,
    super.key,
  });

  final VoidCallback onSuccess;
  final ValueChanged<AppException>? onError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, SingleActionState<T>>(
      listener: (context, state) {
        if (state is SingleActionSuccess<T>) {
          onSuccess();
        } else if (state is SingleActionFailure<T>) {
          final onError = this.onError;
          if (onError == null) {
            context.showSnackBarMessage(
              state.exception.getText(context.l10n),
              isError: true,
            );
            return;
          }

          onError(state.exception);
        }
      },
      builder: (context, state) => LoadingOverlay(
        loading: state is SingleActionLoading<T>,
        child: child,
      ),
    );
  }
}
