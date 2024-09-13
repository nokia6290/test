import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/feature/connectivity/bloc/connectivity_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/explore_card.dart';

class ConnectivityCard extends StatelessWidget {
  const ConnectivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<ConnectivityCubit>().state;
    final connectivityResult =
        result is ConnectivityLoaded ? result.connectivityResult : null;

    return ExploreCard(
      title: context.l10n.connectivity,
      content: Text(connectivityResult?.name ?? '-'),
    );
  }
}
