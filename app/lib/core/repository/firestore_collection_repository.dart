import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/core/provider/firestore_collection_provider.dart';
import 'package:scalable_flutter_app_pro/core/provider/item_provider.dart';
import 'package:scalable_flutter_app_pro/core/repository/item_repository.dart';

class FirestoreCollectionRepository<T> extends ItemRepository<T>
    with RepositoryLoggy
    implements ItemProvider<T> {
  FirestoreCollectionRepository({
    required String collectionName,
    required FromJson<T> fromJson,
    ToJson<T>? toJson,
  }) : firestoreProvider = FirestoreCollectionProvider<T>(
          collectionName: collectionName,
          fromJson: fromJson,
          toJson: toJson,
        );

  final FirestoreCollectionProvider<T> firestoreProvider;

  @override
  Future<List<T>> getAll() => firestoreProvider.getAll();

  @override
  Stream<List<T>> getAllStream() => firestoreProvider.getAllStream();

  @override
  Future<String> add(T item) => firestoreProvider.add(item);

  @override
  Future<void> delete(String id) => firestoreProvider.delete(id);

  @override
  Future<T?> get(String id) => firestoreProvider.get(id);

  @override
  Future<List<T>> getForIds(List<String> ids) =>
      firestoreProvider.getForIds(ids);

  @override
  Stream<T?> getStream(String id) => firestoreProvider.getStream(id);

  @override
  Future<void> update(T item) => firestoreProvider.update(item);
}
