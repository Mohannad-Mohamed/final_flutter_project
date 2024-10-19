import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/widgets/categories_list_view.dart';

import '../widgets/news_list_view_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.blue[50],
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.blueAccent,
              expandedHeight: 250,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              flexibleSpace: FlexibleSpaceBar(
                // title: const Text.rich(TextSpan(children: [TextSpan(text: "NEWS "),TextSpan(text: "APP",style: TextStyle(color: Colors.orange))])),
                // centerTitle: true,
                background: Image.asset('assets/1759492.png',fit: BoxFit.cover,),
              ),
            ),
            const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(10),child: CategoriesListView(),)),
            NewsListViewBuilder(
              category: 'general',
            ),
          ],
        ),
      ),
    );
  }
}
