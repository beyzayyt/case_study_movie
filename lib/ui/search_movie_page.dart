import 'dart:convert';
import 'package:case_study/localization/local_keys.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:case_study/model/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  late Future _data;
  String searchString = "";
  String movieApi = "http://www.omdbapi.com/?s=Joker&page=2&apikey=564727fa";

  Future<List<Movie>> _fetchAllMovies() async {
    final response = await http.get(Uri.parse(movieApi));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies!");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _data = _fetchAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Theme.of(context).brightness),
        backgroundColor: Colors.amber[100],
        elevation: 0,
        title: Text(LocaleKeys.searchMovieTitle.tr(), style: Theme.of(context).textTheme.headline5),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              cursorColor: Colors.amber,
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  hintStyle: Theme.of(context).textTheme.subtitle1,
                  labelText: LocaleKeys.searchHint.tr(),
                  suffixIcon: const Icon(Icons.search)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: FutureBuilder(
                  future: _data,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (kDebugMode) {
                      print(snapshot.data);
                    }
                    if (snapshot.data == null) {
                      return Center(
                          child: Text(LocaleKeys.searchLoading.tr(), style: Theme.of(context).textTheme.subtitle2));
                    } else {
                      return ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data[index].title.toLowerCase().contains(searchString)
                                ? ListTile(
                                    onTap: () {},
                                    title: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data[index].title,
                                              style: Theme.of(context).textTheme.subtitle1),
                                          Text(snapshot.data[index].year, style: Theme.of(context).textTheme.subtitle1),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return snapshot.data[index].title.toLowerCase().contains(searchString)
                                ? const Divider()
                                : Container();
                          },
                          itemCount: snapshot.data.length);
                    }
                  }))
        ],
      ),
    );
  }
}