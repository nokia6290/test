import 'package:scalable_flutter_app_pro/core/bloc/single_action_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/analytics/repository/analytics_repository.dart';
import 'package:scalable_flutter_app_pro/feature/article/model/article.dart';
import 'package:scalable_flutter_app_pro/feature/article/repository/article_repository.dart';

class ArticleAddCubit extends SingleActionCubit<ArticleAddCubit> {
  ArticleAddCubit({
    required this.articleRepository,
    required this.analyticsRepository,
  });

  final ArticleRepository articleRepository;
  final AnalyticsRepository analyticsRepository;

  void add(Article article) {
    doAction(
      () => articleRepository.add(article),
      onSuccess: () => analyticsRepository.logArticleAdded,
    );
  }
}
