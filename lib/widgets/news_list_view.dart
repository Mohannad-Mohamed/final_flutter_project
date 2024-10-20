import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/models/article_model.dart';

import 'news_tile.dart';

class NewsListView extends StatelessWidget {
  final List<ArticleModel> articles;

  const NewsListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    // Filter articles with valid image URLs
    final validArticles = articles.where((article) {
      return article.image != null &&
          article.image!.startsWith('http') &&
          article.image!.isNotEmpty;
    }).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: validArticles.length,
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: NewsTile(
              articleModel: validArticles[index],
            ),
          );
        },
      ),
    );
  }
}