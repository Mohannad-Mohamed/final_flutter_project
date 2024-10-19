import 'package:dio/dio.dart';
import 'package:news_app_ui_setup/models/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<ArticleModel>> getTopHeadlines({required String category}) async {
    try {
      // Log the category being fetched
      print("Fetching top headlines for category: $category");

      // Fetching data from the News API
      var response = await dio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': '3c88955c487e4d9db668f011dd85e737', // Keep your API key here
          'category': category,
        },
      );

      // Log the entire response
      print("Response received: ${response.data}");

      // Check if the response status is successful
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;

        // Validate the response data
        if (jsonData['articles'] != null) {
          List<dynamic> articles = jsonData['articles'];

          // Check if articles are empty
          if (articles.isNotEmpty) {
            // Map articles to ArticleModel list and filter out removed articles
            List<ArticleModel> articlesList = articles
                .map((article) => ArticleModel.fromJson(article))
                .where((article) =>
                    article.subTitle != null &&
                    !article.title.toLowerCase().contains('removed') &&
                    !article.subTitle!.toLowerCase().contains('removed'))
                .toList();

            print("Retrieved ${articlesList.length} filtered articles.");
            return articlesList; // Return the filtered list of articles
          } else {
            print("No articles found in the response.");
            return []; // Return an empty list if no articles
          }
        } else {
          print("Articles key is null in the response.");
          return []; // Return an empty list if articles key is null
        }
      } else {
        // Log if the response status code is not 200
        print("Error: ${response.statusCode} - ${response.statusMessage}");
        return []; // Return an empty list if the API call was unsuccessful
      }
    } catch (e) {
      // Handle any errors during the API call
      print("Error fetching articles: $e");
      return []; // Return an empty list on error
    }
  }
}
