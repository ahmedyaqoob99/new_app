import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/helper/health.dart';
import 'package:news_app/model/favourite_model.dart';
import 'package:news_app/screens/detail_screen.dart';

class HealthWidget extends StatefulWidget {
  const HealthWidget({Key? key}) : super(key: key);

  @override
  State<HealthWidget> createState() => _HealthWidgetState();
}

class _HealthWidgetState extends State<HealthWidget> {
  getNewsData() async {
    Health newsClass = Health();
    await newsClass.getNews();
    return newsClass.newsList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Products products = Products();

    return Container(
      height: size.height,
      child: FutureBuilder(
        future: getNewsData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
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
                  child: Card(
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: Hero(
                        tag: snapshot.data[index].title,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.purple,
                                strokeWidth: 3,
                              ),
                            ),
                            imageUrl: snapshot.data[index].urlToImage,
                            fit: BoxFit.fitHeight,
                            width: 80,
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data[index].title,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            // color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data[index].publishedAt,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            // color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                          onTap: () {
                            products.itemList.add(
                              Product(
                                author: snapshot.data[index].author,
                                title: snapshot.data[index].title,
                                category: snapshot.data[index].category,
                                description: snapshot.data[index].description,
                                image: snapshot.data[index].urlToImage,
                                source: snapshot.data[index].url,
                                publishedAt: snapshot.data[index].publishedAt,
                                url: snapshot.data[index].url,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(products.items.toString())));
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20.0,
                          )),
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(child: Text("loading..."));
        },
      ),
    );
  }
}
