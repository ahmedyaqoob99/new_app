import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class General {
  List<NewsModel> newsList = [];

  Future<void> getNews() async {
    try {
      var url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a8924996f914478080395cbd19c4e075");
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == "ok") {
        for (var item in jsonData['articles']) {
          String title;
          String author;
          String url;
          String urlToImage;
          String description;
          String content;
          String publishedAt;
          if (item['author'] != null) {
            author = item['author'];
          } else {
            author = "";
          }
          if (item['title'] != null) {
            title = item['title'];
          } else {
            title = "";
          }
          if (item['description'] != null) {
            description = item['description'];
          } else {
            description = "";
          }
          if (item['url'] != null) {
            url = item['url'];
          } else {
            url = "";
          }
          if (item['urlToImage'] != null) {
            urlToImage = item['urlToImage'];
          } else {
            urlToImage =
                "https://c1.wallpaperflare.com/preview/550/722/478/5ad74bbabbbb6.jpg";
          }
          if (item['publishedAt'] != null) {
            publishedAt = item['publishedAt'];
          } else {
            publishedAt = "";
          }
          if (item['content'] != null) {
            content = item['content'];
          } else {
            content = "";
          }
          try {
            NewsModel articleModel = NewsModel(
              title: title,
              author: author,
              content: content,
              description: description,
              urlToImage: urlToImage,
              url: url,
              publishedAt: publishedAt,
            );
            newsList.add(articleModel);
          } catch (e) {
            print("Article Model Error ==> $e");
          }
        }
      }
    } catch (e) {
      print("News Api Error -->> $e");
    }
  }
}
