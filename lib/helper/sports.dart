import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/sports_model.dart';

class News {
  List<SportsModel> newsList = [];

  Future<void> getNews() async {
    try {
      var url = Uri.parse(
          "http://api.mediastack.com/v1/news?access_key=880ca5c4f3c81a5227dc07a33cf1ba72&categories=sports&languages=en");
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);

      for (var item in jsonData['data']) {
        try {
          String title;
          String author;
          String url;
          String source;
          String image;
          String description;
          String category;
          String language;
          String publishedAt;
          String country;
          if (item['title'] != null) {
            title = item['title'];
          } else {
            title = "";
          }
          if (item['author'] != null) {
            author = item['author'];
          } else {
            author = "";
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
          if (item['source'] != null) {
            source = item['source'];
          } else {
            source = "";
          }
          if (item['image'] != null) {
            image = item['image'];
          } else {
            image =
                "https://thumbs.dreamstime.com/b/sports-tools-balls-shoes-ground-108686133.jpg";
          }
          if (item['category'] != null) {
            category = item['category'];
          } else {
            category = "";
          }
          if (item['language'] != null) {
            language = item['language'];
          } else {
            language = "";
          }
          if (item['published_at'] != null) {
            publishedAt = item['published_at'];
          } else {
            publishedAt = "";
          }
          if (item['country'] != null) {
            country = item['country'];
          } else {
            country = "";
          }
          SportsModel sportsModel = SportsModel(
            title: title,
            author: author,
            description: description,
            url: url,
            source: source,
            image: image,
            category: category,
            language: language,
            publishedAt: publishedAt,
            country: country,
          );
          newsList.add(sportsModel);
        } catch (e) {
          print("Article Model Error ==> $e");
        }
      }
    } catch (e) {
      print("Stack Api Error -->> $e");
    }
  }
}
