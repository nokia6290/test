import 'package:hive/hive.dart';
import 'package:scalable_flutter_app_pro/core/provider/firestore_collection_provider.dart';
import 'package:scalable_flutter_app_pro/core/provider/item_provider.dart';

enum HiveBoxName {
  articles('articles'),
  ;

  const HiveBoxName(this.id);

  final String id;
}

abstract class HiveBoxProvider<T> extends ItemProvider<T> {
  const HiveBoxProvider({
    required this.boxName,
    required this.fromJson,
    required this.toJson,
  });

  final HiveBoxName boxName;
  final FromJson<T> fromJson;
  final ToJson<T> toJson;

  Future<bool> get isEmpty async => (await _box).isEmpty;

  @override
  Future<T?> get(String id) async {
    if (id.isEmpty) {
      return null;
    }

    final box = await _box;
    final json = box.get(id);
    return json == null ? null : fromJson(Map.from(json));
  }

  @override
  Future<List<T>> getForIds(List<String> ids) async {
    if (ids.isEmpty) {
      return const [];
    }

    final box = await _box;
    final items = <T>[];
    for (final id in ids) {
      final json = box.get(id);
      if (json != null) {
        items.add(fromJson(Map.from(json)));
      }
    }

    return items;
  }

  @override
  Stream<T?> getStream(String id) async* {
    if (id.isEmpty) {
      yield* Stream.value(null);
      return;
    }

    final box = await _box;
    yield* box.watch(key: id).map((event) {
      return event.value as T?;
    });
  }

  @override
  Stream<List<T>> getAllStream() async* {
    final box = await _box;
    yield* box.watch().map((event) => event.value as List<T>);
  }

  @override
  Future<List<T>> getAll() async {
    final box = await _box;
    return box.values.map((e) => fromJson(Map.from(e))).toList();
  }

  @override
  Future<String> add(T item) async {
    final json = toJson(item);
    final id = json['id'] as String;

    final box = await _box;
    await box.put(id, json);
    return id;
  }

  @override
  Future<String> update(T item) async {
    final json = toJson(item);
    final id = json['id'] as String;

    final box = await _box;
    await box.put(id, json);
    return id;
  }

  @override
  Future<void> delete(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  Future<Box<Map<dynamic, dynamic>>> get _box => Hive.openBox(boxName.id);
}
