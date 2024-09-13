part of 'items_cubit.dart';

@immutable
sealed class ItemsState<T> {
  const ItemsState();
}

class ItemsInitial<T> extends ItemsState<T> {
  const ItemsInitial();
}

class ItemsLoaded<T> extends ItemsState<T> {
  const ItemsLoaded({required this.items});

  final List<T> items;
}
