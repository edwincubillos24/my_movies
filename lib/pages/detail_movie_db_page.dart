import 'package:flutter/material.dart';
import 'package:my_movies/boxes.dart';
import 'package:my_movies/models/apimoviedb_top_rated_response.dart';
import 'package:my_movies/models/local_movie.dart';

class DetailMovieDbPage extends StatefulWidget {
  final Movies movie;

  const DetailMovieDbPage(this.movie, {super.key});

  @override
  State<DetailMovieDbPage> createState() => _DetailMovieDbPageState(movie);
}

class _DetailMovieDbPageState extends State<DetailMovieDbPage> {
  final Movies movie;

  _DetailMovieDbPageState(this.movie);

  void _saveMovieInFavorites() {
    var localMovie = LocalMovie()
      ..id = movie.id?.toInt()
      ..title = movie.title
      ..backdropPath = movie.backdropPath
      ..releaseDate = movie.releaseDate
      ..voteAverage = movie.voteAverage?.toDouble()
      ..overview = movie.overview;

    final box = Boxes.getLocalMovieBox();
    box.add(localMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? 'Detalle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
              const SizedBox(
                height: 4.0,
              ),
              IconButton(
                alignment: Alignment.bottomLeft,
                icon: const Icon(Icons.favorite_border),
                onPressed: _saveMovieInFavorites,
              ),
              Text(
                'Release date: ${movie.releaseDate}',
                style: const TextStyle(fontSize: 17.0),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Average: ${movie.voteAverage}',
                style: const TextStyle(fontSize: 17.0),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Overview: \n\n${movie.overview}',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 17.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
