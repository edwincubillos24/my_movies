import 'package:flutter/material.dart';
import 'package:my_movies/repository/moviedb_api.dart';

import '../models/apimoviedb_top_rated_response.dart';

class MovieDbPage extends StatefulWidget {
  const MovieDbPage({super.key});

  @override
  State<MovieDbPage> createState() => _MovieDbPageState();
}

class _MovieDbPageState extends State<MovieDbPage> {
  final MoviedbApi moviedbApi = MoviedbApi();
  List<Results> listMovies = <Results>[];

  Future<void> _getTopRated() async {
    var results = await moviedbApi.getTopRated();
    setState(() {
      listMovies = results.results!;
    });
  }

  @override
  void initState() {
    _getTopRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView.builder(
              itemCount: listMovies.length,
              itemBuilder: (BuildContext context, int index) {
                Results movie = listMovies[index];
                return Card(
                  child: ListTile(
                    title: Text(movie.title!),
                    subtitle: Text("Average: ${movie.voteAverage}"),
                    leading: Image.network(
                        "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
