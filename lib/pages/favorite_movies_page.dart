import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_movies/boxes.dart';
import 'package:my_movies/models/local_movie.dart';

class FavoriteMoviesPage extends StatefulWidget {
  const FavoriteMoviesPage({super.key});

  @override
  State<FavoriteMoviesPage> createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _buildListView(),
        ),
      ),
    );
  }
}

Widget _buildListView() {
  return ValueListenableBuilder<Box<LocalMovie>>(
      valueListenable: Boxes.getLocalMovieBox().listenable(),
      builder: (context, box, _) {
        final movieBox = box.values.toList().cast<LocalMovie>();
        return ListView.builder(
          itemCount: movieBox.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movieBox[index];
            return Card(
              child: ListTile(
                  title: Text(movie.title ?? 'No title'),
                  subtitle: Text(movie.releaseDate ?? 'No release date'),
                  leading: Image.network(
                      "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
                  onLongPress: () {
                    movie.delete();
                  } //_showAlertDialog(context, movie),
              ),
            );
          },
        );
      });
}

_showAlertDialog(BuildContext context, LocalMovie movie) {
  AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content: Text(
          "¿Esta seguro que desea eliminar la pelicula ${movie
              .title} de sus favoritos?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
            child: const Text('Aceptar'),
            onPressed: () =>
            {

              Navigator.pop(context, 'OK'),
            }),
      ]);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
