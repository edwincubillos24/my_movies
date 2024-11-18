import 'package:hive/hive.dart';
import 'package:my_movies/models/local_movie.dart';

class Boxes {

  static Box<LocalMovie> getLocalMovieBox() => Hive.box<LocalMovie>('movies');

}
