import 'package:scalable_flutter_app_pro/core/provider/item_provider.dart';
import 'package:scalable_flutter_app_pro/core/repository/item_repository.dart';
import 'package:scalable_flutter_app_pro/feature/article/model/article.dart';
import 'package:scalable_flutter_app_pro/feature/article/provider/article_cloud_functions_provider.dart';
import 'package:scalable_flutter_app_pro/feature/article/provider/article_dio_provider.dart';

class ArticleRepository extends ItemRepository<Article> {
  ArticleRepository({
    required this.remoteProvider,
    required this.localProvider,
    required this.httpProvider,
  });

  final ItemProvider<Article> remoteProvider;
  final ItemProvider<Article> localProvider;
  final ArticleDioProvider httpProvider;
  final _cloudFunctions = ArticleCloudFunctionsProvider();

  @override
  Future<List<Article>> getAll() async {
    final result = await Future.wait([
      remoteProvider.getAll(),
      localProvider.getAll(),
      getHackerNewsArticles(),
    ]);

    final articles = [
      ...result[0],
      ...result[1],
      ...result[2],
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return articles;
  }

  @override
  Stream<List<Article>> getAllStream() {
    throw UnimplementedError();
  }

  Future<bool> add(Article article) {
    return _cloudFunctions.articleAdd(
      title: article.title,
      subtitle: article.subtitle,
      text: article.text,
    );
  }

  Future<List<Article>> getHackerNewsArticles() async {
    final data = await httpProvider.getArticle(8863);
    return [Article.fromHackerNews(data)];
  }
}
