import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/article_model.dart';

class News {
  List<ArticleModel> newsList = [];

  Future<void> getNews() async {
    try {
      var url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a8924996f914478080395cbd19c4e075");
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == "ok") {
        for (var item in jsonData['articles']) {
          if (item['author'] != null &&
              item['title'] != null &&
              item['description'] != null &&
              item['url'] != null &&
              item['urlToImage'] != null &&
              item['publishedAt'] != null &&
              item['content'] != null) {
            try {
              ArticleModel articleModel = ArticleModel(
                title: item['title'],
                author: item['author'],
                content: item['content'],
                description: item['description'],
                urlToImage: item['urlToImage'],
                url: item['url'],
                publishedAt: item['publishedAt'],
              );
              newsList.add(articleModel);
            } catch (e) {
              print("Article Model Error ==> $e");
            }
          }
        }
      }
    } catch (e) {
      print("News Api Error -->> $e");
    }
  }
}
