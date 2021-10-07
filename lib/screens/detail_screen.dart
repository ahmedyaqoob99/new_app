import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  late String author;
  String title;
  String description;
  String url;
  String source;
  String image;
  String publishedAt;

  DetailScreen({
    Key? key,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    required this.image,
    required this.publishedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
          backgroundColor: Colors.white.withOpacity(0),
        ),
        body: Stack(
          children: [
            Hero(
              tag: title,
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                    strokeWidth: 3,
                  ),
                ),
                imageUrl: image,
                fit: BoxFit.fitHeight,
                height: size.height,
                width: size.width,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Author: $author",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  // color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              // color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          publishedAt,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "View More",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  // color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
