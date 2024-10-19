import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/models/article_model.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    // Define a fallback URL for invalid or missing image links
    const String fallbackImageUrl = 'https://via.placeholder.com/200';

    // Check if the image URL is valid
    final String imageUrl = (articleModel.image != null &&
            (articleModel.image!.startsWith('http://') ||
                articleModel.image!.startsWith('https://')))
        ? articleModel.image!
        : fallbackImageUrl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                fallbackImageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          articleModel.title ?? 'No title', // Default title if null
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          articleModel.subTitle ?? 'No Subtitle Available', // Default subtitle if null
          maxLines: 2,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
