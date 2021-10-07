import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String author;
  final String title;
  final String description;
  final String url;
  final String source;
  final String image;
  final String category;
  final String publishedAt;

  Product({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    required this.image,
    required this.category,
    required this.publishedAt,
  });
}

class Products with ChangeNotifier {
  List<Product> itemList = [];

  List<Product> get items {
    return [...itemList];
  }

  Product findById(String title) {
    return itemList.firstWhere((pdt) => pdt.title == title);
  }
}
