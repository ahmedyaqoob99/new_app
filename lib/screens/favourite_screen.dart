import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/favourite_model.dart';

import 'login_page.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Products product = Products();

    return Container(
      child: FirebaseAuth.instance.currentUser != null
          ? ListView.builder(
              itemCount: product.items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                            strokeWidth: 3,
                          ),
                        ),
                        imageUrl: product.itemList[index].image,
                        fit: BoxFit.fitHeight,
                        width: 80,
                      ),
                    ),
                    title: Text(
                      product.itemList[index].title,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          // color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      product.itemList[index].publishedAt,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          // color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 100),
                const Icon(
                  Icons.person,
                  size: 60,
                ),
                Text(
                  "Guest",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      // color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  "If you want to see Favourite News, Please SignIn First! Thanks",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      // color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        // color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
