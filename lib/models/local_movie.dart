import 'package:hive/hive.dart';

part 'local_movie.g.dart';

@HiveType(typeId: 0)
class LocalMovie extends HiveObject{

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? backdropPath;

  @HiveField(3)
  String? releaseDate;

  @HiveField(4)
  double? voteAverage;

  @HiveField(5)
  String? overview;

}