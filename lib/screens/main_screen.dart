import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/favourite_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/widgets/business_widget.dart';
import 'package:news_app/screens/widgets/health_widget.dart';
import 'package:news_app/screens/widgets/sports_widget.dart';
import 'package:news_app/screens/widgets/technology_widget.dart';
import 'package:news_app/screens/widgets/top_news_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  Color? colorOne = Colors.purple;
  Color? colorTwo = Colors.white;
  Color? colorThree = Colors.white;
  Color? colorFour = Colors.white;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    Widget Home() {
      return Column(
        children: [
          const Expanded(
            flex: 5,
            child: TopNewsWidget(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    colorOne = Colors.purple;
                    colorTwo = Colors.white;
                    colorThree = Colors.white;
                    colorFour = Colors.white;
                  });
                },
                child: const Text(
                  "Business",
                ),
                style: ElevatedButton.styleFrom(
                  primary: colorOne,
                  onPrimary: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);

                  setState(() {
                    colorOne = Colors.white;
                    colorTwo = Colors.purple;
                    colorThree = Colors.white;
                    colorFour = Colors.white;
                  });
                },
                child: const Text(
                  "Technology",
                ),
                style: ElevatedButton.styleFrom(
                  primary: colorTwo,
                  onPrimary: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(3,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);

                  setState(() {
                    colorOne = Colors.white;
                    colorTwo = Colors.white;
                    colorThree = Colors.purple;
                    colorFour = Colors.white;
                  });
                },
                child: const Text(
                  "Health",
                ),
                style: ElevatedButton.styleFrom(
                  primary: colorThree,
                  onPrimary: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(4,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);

                  setState(() {
                    colorOne = Colors.white;
                    colorTwo = Colors.white;
                    colorThree = Colors.white;
                    colorFour = Colors.purple;
                  });
                },
                child: const Text(
                  "Sports",
                ),
                style: ElevatedButton.styleFrom(
                  primary: colorFour,
                  onPrimary: Colors.black,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: _pageController,
              children: const [
                BusinessWidget(),
                TechnologyWidget(),
                HealthWidget(),
                SportWidget(),
              ],
            ),
          ),
        ],
      );
    }

    List<Widget> _pages = <Widget>[
      Home(),
      SearchScreen(),
      FavouriteScreen(),
      ProfileScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "News App",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple),
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favourite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.purple,
          selectedLabelStyle: TextStyle(letterSpacing: 1),
          backgroundColor: Colors.white,
          onTap: _onTap,
          type: BottomNavigationBarType.shifting,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _pages.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
