import 'package:scalable_flutter_app_pro/core/bloc/items_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/article/model/article.dart';
import 'package:scalable_flutter_app_pro/feature/article/repository/article_repository.dart';

class ArticlesCubit extends ItemsCubit<Article, ArticleRepository> {
  ArticlesCubit({
    required ArticleRepository articleRepository,
  }) : super(itemRepository: articleRepository);
}
