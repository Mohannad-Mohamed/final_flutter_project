import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/widgets/categories_list_view.dart';
import '../widgets/news_list_view_builder.dart';

class CategoryView extends StatelessWidget {
  final String category;

  const CategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text(
          '$category News',
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Container(
        color: Colors.blue[50],
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CategoriesListView(),
              ), // Keeps the categories list view at the top
            ),
            NewsListViewBuilder(
              category: category,
            ),
          ],
        ),
      ),
    );
  }
}
