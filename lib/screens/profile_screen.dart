import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    logOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }

    double maxWidth = MediaQuery.of(context).size.width;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Padding(
      padding: const EdgeInsets.all(20),
      child: FirebaseAuth.instance.currentUser != null
          ? FutureBuilder<DocumentSnapshot>(
              future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      const Center(
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.account_circle),
                          hintText: "${data['name']}",
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          hintText: "${data['email']}",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              logOut();
                            },
                            child: Row(
                              children: [
                                Text("Logout "),
                                Icon(Icons.logout),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
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
                  "Do you want to SignIn?",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      // color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
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
