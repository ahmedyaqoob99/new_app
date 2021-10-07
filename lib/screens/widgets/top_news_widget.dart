import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/helper/general.dart';
import 'package:news_app/screens/detail_screen.dart';

class TopNewsWidget extends StatefulWidget {
  const TopNewsWidget({Key? key}) : super(key: key);

  @override
  State<TopNewsWidget> createState() => _TopNewsWidgetState();
}

class _TopNewsWidgetState extends State<TopNewsWidget> {
  getNewsData() async {
    General newsClass = General();
    await newsClass.getNews();
    return newsClass.newsList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              "Top News",
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4),
            ),
          ),
          Container(
            height: size.height * 0.48,
            child: FutureBuilder(
              future: getNewsData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return DetailScreen(
                                author: snapshot.data[index].author,
                                title: snapshot.data[index].title,
                                description: snapshot.data[index].description,
                                image: snapshot.data[index].urlToImage,
                                source: snapshot.data[index].url,
                                publishedAt: snapshot.data[index].publishedAt,
                                url: snapshot.data[index].url,
                              );
                            }),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                    strokeWidth: 3,
                                  ),
                                ),
                                imageUrl: snapshot.data[index].urlToImage,
                                fit: BoxFit.fitHeight,
                                height: size.height * 35,
                                width: size.width * 0.60,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: size.width * 0.60,
                                height: size.height * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black54,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        snapshot.data[index].author,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        snapshot.data[index].publishedAt,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Center(child: Text("loading..."));
              },
            ),
          ),
        ],
      ),
    );
  }
}
