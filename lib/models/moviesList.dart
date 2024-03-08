// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:entertainment/models/appConfigModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MoviesList {
  final String? name;
  final String? language;
  final bool? isAdult;
  final String? description;
  final String posterPath;
  final String? backdropPath;
  final num? rating;
  final String? releaseDate;

  MoviesList({
    this.name,
    this.language,
    this.isAdult,
    this.description,
    required this.posterPath,
    this.backdropPath,
    this.rating,
    this.releaseDate,
  });

  factory MoviesList.fromJson(Map<String, dynamic> json) {
    return MoviesList(
      name: json['title'],
      language: json['original_language'],
      isAdult: json['adult'],
      description: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: json['vote_average'],
      releaseDate: json['release_date'],
    );
  }

  String posterURL() {
    final AppConfigModel appConfigModel = GetIt.instance.get<AppConfigModel>();
    return '${appConfigModel.BASE_IMAGE_API_URL}$posterPath';
  }
}
