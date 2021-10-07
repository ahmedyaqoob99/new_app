import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List names = [];
  List filteredNames = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = Text(
    'Search News',
    style: GoogleFonts.poppins(
      textStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
    ),
  );

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    // _getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: _searchPressed,
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: _appBarTitle,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://th.bing.com/th/id/R.6abefd451085322d45e71128ef2339ad?rik=SiWgBdDIyspu7A&riu=http%3a%2f%2fgifimage.net%2fwp-content%2fuploads%2f2017%2f09%2fanimated-gif-search.gif&ehk=Z0Um2o3vSlk38xP7XYeqGnqYi%2b11v9LPJ0ULGM%2b9Ao8%3d&risl=&pid=ImgRaw&r=0"),
              ),
            ),
            child: FutureBuilder(
                future: _getNames(),
                builder: (context, AsyncSnapshot snap) {
                  return _buildList();
                }),
          ),
        ],
      ),
    );
  }

  _buildBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      actions: [
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ],
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close, color: Colors.purple);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.purple),
            hintText: _filter.text,
            label: Text("Search Here"),
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search, color: Colors.purple);
        _appBarTitle = Text(
          'Search News',
          style: GoogleFonts.poppins(
            textStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
          ),
        );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  _getNames() async {
    final response = await http.get(Uri.parse(
        'http://api.mediastack.com/v1/news?access_key=880ca5c4f3c81a5227dc07a33cf1ba72&languages=en&search=${_filter.text}'));
    var jsonData = jsonDecode(response.body);
    List tempList = [];
    for (int i = 0; i < jsonData[0].length; i++) {
      tempList.add(jsonData[0][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
