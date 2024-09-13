import 'dart:async';
import 'dart:typed_data';

import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/core/provider/item_provider.dart';
import 'package:scalable_flutter_app_pro/feature/auth/provider/auth_provider.dart';
import 'package:scalable_flutter_app_pro/feature/storage/provider/firebase_storage_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';
import 'package:scalable_flutter_app_pro/feature/user/provider/user_cloud_functions_provider.dart';

class UserRepository with RepositoryLoggy {
  UserRepository({
    required this.userProvider,
    required this.authProvider,
    required this.storageProvider,
    required this.cloudFunctions,
  });

  final ItemProvider<User> userProvider;
  final AuthProvider authProvider;
  final FirebaseStorageProvider storageProvider;
  final UserCloudFunctionsProvider cloudFunctions;

  Stream<User?> getUserStream() {
    final transformer = StreamTransformer<String?, User?>.fromHandlers(
      handleData: (userId, output) {
        if (userId == null) {
          output.add(null);
        } else {
          userProvider
              .getStream(userId)
              .listen(output.add)
              .onError((error, [stackTrace]) => output.add(null));
        }
      },
    );

    return authProvider.getUserIdStream().transform(transformer);
  }

  Future<void> logOut() {
    return authProvider.logOut();
  }

  Future<bool> uploadPhoto({
    required String userId,
    required String filePath,
    required Uint8List bytes,
  }) async {
    final photoUrl = await storageProvider.uploadUserPhoto(
      userId: userId,
      filePath: filePath,
      bytes: bytes,
    );

    loggy.info('uploadPhoto - photoUrl: $photoUrl');

    if (photoUrl == null) {
      return false;
    }

    return cloudFunctions.setUserPhoto(imageUrl: photoUrl);
  }
}
