import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/main.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
RegExp regExps = new RegExp(pattern);

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool passHide = true;

  bool isChange = false;
  bool isGuest = false;

  @override
  Widget build(BuildContext context) {
    login() async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text,
          password: passController.text,
        );
        usernameController.clear();
        passController.clear();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
        setState(() {
          isChange = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No user found for that email.")));

          setState(() {
            isChange = false;
          });
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wrong password provided for that user.')));

          setState(() {
            isChange = false;
          });
          print('Wrong password provided for that user.');
        }
      }
    }

    void validation() {
      final _form = _formKey.currentState;
      if (_form!.validate()) {
        login();
      } else {
        setState(() {
          isChange = false;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Please fill Email";
                    } else if (!regExp.hasMatch(value)) {
                      return "Email is Invalid";
                    }
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(CupertinoIcons.envelope),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passController,
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Please fill Password";
                    } else if (value.length < 8) {
                      return "Password is less than 8";
                    }
                  },
                  obscureText: passHide,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(CupertinoIcons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // FocusScope.of(context).unfocus();
                        setState(() {
                          passHide = false;
                        });
                      },
                      child: passHide
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isChange = true;
                    });

                    await Future.delayed(const Duration(seconds: 1));
                    validation();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: isChange ? 45 : 160,
                    height: isChange ? 45 : 45,
                    alignment: Alignment.center,
                    child: isChange
                        ? const Icon(Icons.done_all)
                        : FittedBox(
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(isChange ? 45 : 8),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isGuest = true;
                    });
                    await Future.delayed(const Duration(seconds: 1));
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: isGuest ? 45 : 160,
                    height: isGuest ? 45 : 45,
                    alignment: Alignment.center,
                    child: isGuest
                        ? const Icon(Icons.done_all)
                        : FittedBox(
                            child: Text(
                              "Login As Guest",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(isGuest ? 45 : 8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      ),
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
