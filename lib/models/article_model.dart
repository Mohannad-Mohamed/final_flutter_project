class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String url; // Include the URL field

  ArticleModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.url, // Include the URL in the constructor
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['urlToImage'],
      title: json['title'],
      subTitle: json['description'],
      url: json['url'], // Map the URL from the JSON response
    );
  }
}
