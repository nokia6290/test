import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalable_flutter_app_pro/core/bloc/items_cubit.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ItemsListView<T, C extends Cubit<ItemsState<T>>> extends StatelessWidget {
  const ItemsListView({
    required this.itemBuilder,
    super.key,
    this.emptyBuilder,
    this.padding = 8,
    this.itemPadding = 8,
  });

  final ItemWidgetBuilder<T> itemBuilder;
  final WidgetBuilder? emptyBuilder;
  final double padding;
  final double itemPadding;

  @override
  Widget build(BuildContext context) {
    final itemsState = context.watch<C>().state;
    if (itemsState is! ItemsLoaded<T>) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final items = itemsState.items;
    if (items.isEmpty) {
      return Center(
        child: emptyBuilder?.call(context) ?? Text(context.l10n.listIsEmpty),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(padding),
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (context, index) => SizedBox(height: itemPadding),
    );
  }
}
