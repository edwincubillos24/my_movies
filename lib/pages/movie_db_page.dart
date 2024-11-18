import 'package:flutter/material.dart';
import 'package:my_movies/pages/detail_movie_db_page.dart';
import 'package:my_movies/repository/moviedb_api.dart';

import '../models/apimoviedb_top_rated_response.dart';

class MovieDbPage extends StatefulWidget {
  const MovieDbPage({super.key});

  @override
  State<MovieDbPage> createState() => _MovieDbPageState();
}

class _MovieDbPageState extends State<MovieDbPage> {
  final MoviedbApi moviedbApi = MoviedbApi();
  List<Movies> listMovies = <Movies>[];

  Future<void> _getTopRated() async {
    var remoteResponse = await moviedbApi.getTopRated();
    setState(() {
      listMovies = remoteResponse.listMovies!;
    });
  }

  @override
  void initState() {
    super.initState();
    _getTopRated();
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
                Movies movie = listMovies[index];
                return Card(
                  child: ListTile(
                    title: Text(movie.title!),
                    subtitle: Text("Average: ${movie.voteAverage}"),
                    leading: Image.network(
                        "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => DetailMovieDbPage(movie)));
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
