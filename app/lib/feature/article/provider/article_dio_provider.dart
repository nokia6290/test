import 'package:scalable_flutter_app_pro/core/provider/dio_http_provider.dart';

class ArticleDioProvider extends DioHttpProvider {
  ArticleDioProvider()
      : super(
          baseUrl: 'https://hacker-news.firebaseio.com/v0/',
        );

  Future<Map<String, dynamic>> getArticle(int id) async {
    final result = await get('item/$id.json');
    return result.data!;
  }
}
