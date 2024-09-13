import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:scalable_flutter_app_pro/core/provider/item_provider.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef ToJson<T> = Map<String, dynamic> Function(T item);

class FirestoreCollectionProvider<T> extends ItemProvider<T> {
  const FirestoreCollectionProvider({
    required this.collectionName,
    required this.fromJson,
    this.toJson,
  });

  final String collectionName;
  final FromJson<T> fromJson;
  final ToJson<T>? toJson;

  String get newId => collection.doc().id;

  @override
  Future<T?> get(String id) async {
    if (id.isEmpty) {
      return null;
    }

    final snapshot = await collection.doc(id).get();
    return snapshot.exists ? fromDoc(snapshot) : null;
  }

  @override
  Stream<T?> getStream(String id) {
    if (id.isEmpty) {
      return Stream.value(null);
    }

    return collection
        .doc(id)
        .snapshots()
        .map((snapshot) => snapshot.exists ? fromDoc(snapshot) : null);
  }

  @override
  Stream<List<T>> getAllStream() {
    return collection
        .snapshots()
        .map((snapshot) => snapshot.docs.map(fromDoc).toList());
  }

  @override
  Future<List<T>> getAll() async {
    final snapshot = await collection.get();
    return snapshot.docs.map(fromDoc).toList();
  }

  @override
  Future<List<T>> getForIds(List<String> ids) async {
    if (ids.isEmpty) {
      return [];
    }

    final snapshot =
        await collection.where(FieldPath.documentId, whereIn: ids).get();
    return snapshot.docs.map(fromDoc).toList();
  }

  @override
  Future<String> add(T item) async {
    final data = toJson?.call(item);
    if (data == null) {
      throw ArgumentError('toJson is not set');
    }

    if (data['id'] != '') {
      throw ArgumentError('id must be empty');
    }

    data.remove('id');
    final doc = await collection.add(data);
    return doc.id;
  }

  @override
  Future<void> update(T item) async {
    final data = toJson?.call(item);
    if (data == null) {
      throw ArgumentError('toJson is not set');
    }

    final id = data['id'];
    if (id is! String || id.isEmpty) {
      throw ArgumentError('id must not be empty');
    }

    data.remove('id');
    return collection.doc(id).update(data);
  }

  @override
  Future<void> delete(String id) {
    if (id.isEmpty) {
      throw ArgumentError('id must not be empty');
    }

    return collection.doc(id).delete();
  }

  @protected
  CollectionReference<Map<String, dynamic>> get collection =>
      FirebaseFirestore.instance.collection(collectionName);

  @protected
  T fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) => fromJson({
        ...?doc.data(),
        'id': doc.id,
      });
}
