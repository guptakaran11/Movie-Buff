// ignore_for_file: file_names
import 'package:entertainment/models/moviesList.dart';
import 'package:entertainment/models/searchCategory.dart';

class HomePageModel {
  final List<MoviesList>? movies;
  final int? page;
  final String? searchCategory;
  final String? searchText;

  HomePageModel({
     this.movies,
     this.page,
     this.searchCategory,
     this.searchText,
  });

  HomePageModel.initial()
      : movies = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  HomePageModel copyWith({
    List<MoviesList>? movies,
    int? page,
    String? searchCategory,
    String? searchText,
  }) {
    return HomePageModel(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
