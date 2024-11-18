import 'dart:convert';

import 'package:my_movies/models/apimoviedb_top_rated_response.dart';
import 'package:http/http.dart' as http;

class MoviedbApi {

  Future<ApimoviedbTopRatedResponse> getTopRated() async {
    final response =
        await http.get(Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=ff29f617b45b36aab5aa78a6fa04677f'));
        print('Respuesta: ${response.body}');
        if (response.statusCode == 200){
          return ApimoviedbTopRatedResponse.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Falla al cargar las peliculas');
        }
  }
}