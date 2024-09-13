import 'package:scalable_flutter_app_pro/core/provider/hive_box_provider.dart';
import 'package:scalable_flutter_app_pro/feature/article/model/article.dart';

class ArticleHiveBoxProvider extends HiveBoxProvider<Article> {
  ArticleHiveBoxProvider()
      : super(
          boxName: HiveBoxName.articles,
          fromJson: Article.fromJson,
          toJson: (article) => article.toJson(),
        );

  @override
  Future<List<Article>> getAll() async {
    if (await isEmpty) {
      await _addDummyArticles();
    }

    return super.getAll();
  }

  Future<void> _addDummyArticles() async {
    await add(
      Article(
        id: '1',
        title: 'Article from Hive 1',
        subtitle: 'This article is read locally from Hive',
        imageUrl: '',
        text: 'Article 1 text',
        createdAt: DateTime.now(),
      ),
    );

    await add(
      Article(
        id: '2',
        title: 'Article from Hive 2',
        subtitle: 'This article is read locally from Hive',
        imageUrl: '',
        text: 'Article 2 text',
        createdAt: DateTime.now(),
      ),
    );
  }
}
