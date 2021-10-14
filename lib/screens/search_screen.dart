import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<NewsModel> newsList = [];
  TextEditingController searchController =
      TextEditingController(text: "sports");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    try {
      var url = Uri.parse(
          "https://newsapi.org/v2/everything?q=${searchController.text}&apiKey=a8924996f914478080395cbd19c4e075");
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
                "https://s.astonaccountants.com.au/wp-content/uploads/businesswoman-670x415.jpg";
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

  searching() {
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: size.height,
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Here",
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: searching,
                child: const Text("Search"),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Card(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        leading: Hero(
                          tag: newsList[index].title,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                  strokeWidth: 3,
                                ),
                              ),
                              imageUrl: newsList[index].urlToImage,
                              fit: BoxFit.fitHeight,
                              width: 80,
                            ),
                          ),
                        ),
                        title: Text(
                          newsList[index].title,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              // color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          newsList[index].publishedAt,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              // color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        trailing: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20.0,
                            )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
