import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs
// For using string URLs directly

// Cached network image
class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});

  final ArticleModel articleModel;

  // Function to open the article URL using launchUrl
  void _launchURL(BuildContext context) async {
    final url = articleModel.url;
    final uri = Uri.parse(url); // Parse the URL string into a Uri object
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Open URL in a browser
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the article'),backgroundColor: Colors.blueAccent,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(context), // Make the tile clickable
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Image.network(
              articleModel.image ?? 'https://via.placeholder.com/200', // Fallback image
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
            child: Column(
              children: [
                Text(
                  articleModel.title ?? 'No Title Available', // Default title if null
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  articleModel.subTitle ?? 'No Subtitle Available', // Default subtitle if null
                  maxLines: 2,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}