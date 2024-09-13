import 'package:scalable_flutter_app_pro/core/provider/firestore_collection_provider.dart';
import 'package:scalable_flutter_app_pro/feature/article/model/article.dart';

class ArticleFirestoreProvider extends FirestoreCollectionProvider<Article> {
  const ArticleFirestoreProvider()
      : super(
          collectionName: 'articles',
          fromJson: Article.fromJson,
        );
}
