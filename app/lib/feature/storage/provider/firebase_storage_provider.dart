import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageProvider {
  final _storage = FirebaseStorage.instance;

  /// Returns download URL if successful, null otherwise.
  Future<String?> uploadUserPhoto({
    required String userId,
    required String filePath,
    required Uint8List bytes,
  }) async {
    final storagePath = _getUserPhotoPath(userId: userId, filePath: filePath);
    return _upload(path: storagePath, bytes: bytes);
  }

  String _getUserPhotoPath({
    required String userId,
    required String filePath,
  }) {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final ext = filePath.split('.').last;
    return 'users/$userId/uploads/$timestamp.$ext';
  }

  Future<String?> _upload({
    required String path,
    required Uint8List bytes,
  }) async {
    final result = await _storage.ref(path).putData(bytes);

    return result.state == TaskState.success
        ? result.ref.getDownloadURL()
        : null;
  }
}
