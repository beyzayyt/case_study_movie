import 'dart:convert';
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

  Future<List<Movie>> _fetchAllMovies() async {
    final response = await http.get(Uri.parse("http://www.omdbapi.com/?s=Joker&page=2&apikey=564727fa"));
    if(response.statusCode == 200) {
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
        backgroundColor: Colors.amber[100],
        elevation: 0,
        title: const Text("Filmler",style: TextStyle(color: Colors.amber)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Ara', suffixIcon: Icon(Icons.search)),
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
                    if(snapshot.data == null) {
                      return const Center(child: Text("Yükleniyor..."));
                    } else {
                      return ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data[index].title.toLowerCase().contains(searchString) ? ListTile(
                              onTap: () {

                              },
                              title: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data[index].title, style: const TextStyle(
                                      fontSize: 18,
                                    ),),
                                    Text(snapshot.data[index].year, style: const TextStyle(
                                      fontSize: 18,
                                    ),),
                                  ],
                                ),
                              ),
                            ) : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return snapshot.data[index].title.toLowerCase().contains(searchString) ? const Divider() : Container();
                          },
                          itemCount: snapshot.data.length
                      );
                    }
                  }
              )
          )
        ],
      ),
    );
  }
}