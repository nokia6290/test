import 'package:scalable_flutter_app_pro/core/provider/firestore_collection_provider.dart';
import 'package:scalable_flutter_app_pro/feature/user/model/user.dart';

class UserFirestoreProvider extends FirestoreCollectionProvider<User> {
  const UserFirestoreProvider()
      : super(
          collectionName: 'users',
          fromJson: User.fromJson,
        );
}
