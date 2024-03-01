// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:entertainment/models/appConfigModel.dart';
import 'package:get_it/get_it.dart';

class MoviesList {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final String backDropPath;
  final num rating;
  final String releaseDate;

  MoviesList({
    required this.name,
    required this.language,
    required this.isAdult,
    required this.description,
    required this.posterPath,
    required this.backDropPath,
    required this.rating,
    required this.releaseDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "original_title": name,
      "original_language": language,
      "adult": isAdult,
      "overview": description,
      "poster_path": posterPath,
      "backdrop_path": backDropPath,
      "vote_average": rating,
      "release_date": releaseDate,
    };
  }

  factory MoviesList.fromMap(Map<String, dynamic> map) {
    return MoviesList(
      name: map["original_title"] as String,
      language: map["original_language"] as String,
      isAdult: map["adult"] as bool,
      description: map["overview"] as String,
      posterPath: map["poster_path"] as String,
      backDropPath: map["backdrop_path"] as String,
      rating: map["vote_average"] as num,
      releaseDate: map["release_date"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesList.fromJson(String source) =>
      MoviesList.fromMap(json.decode(source) as Map<String, dynamic>);

  String posterURL() {
    final AppConfigModel appConfigModel = GetIt.instance.get<AppConfigModel>();
    return '${appConfigModel.BASE_IMAGE_API_URL}$posterPath';
  }
}
