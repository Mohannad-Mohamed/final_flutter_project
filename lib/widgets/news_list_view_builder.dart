import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/models/article_model.dart';
import '../services/news_service.dart';
import 'news_list_view.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  Future<List<ArticleModel>>? future;

  @override
  void initState() {
    super.initState();
    future = NewsService(Dio()).getTopHeadlines(category: widget.category).catchError((error) {
      print("Error fetching articles: $error");
      return <ArticleModel>[]; // Return an empty list if there's an error
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(color: Colors.blueAccent,),
            ),
          );
        } else if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Oops! An error occurred. Please try again later.'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('No articles available.'),
            ),
          );
        } else {
          // Safely using snapshot.data as it is guaranteed to be non-null here
          return NewsListView(articles: snapshot.data!);
        }
      },
    );
  }
}
