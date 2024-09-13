import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/core/navigation/app_route.dart';
import 'package:scalable_flutter_app_pro/core/ui/widget/item/items_list_view.dart';
import 'package:scalable_flutter_app_pro/feature/article/bloc/articles_cubit.dart';
import 'package:scalable_flutter_app_pro/feature/article/model/article.dart';
import 'package:scalable_flutter_app_pro/feature/article/ui/widget/article_card.dart';

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
      ),
      body: ItemsListView<Article, ArticlesCubit>(
        padding: 16,
        itemPadding: 16,
        itemBuilder: (context, article) => ArticleCard(article),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRoute.articleAdd.push(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
