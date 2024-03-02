import 'dart:developer';

import 'package:entertainment/models/homePageModel.dart';
import 'package:entertainment/models/moviesList.dart';
import 'package:entertainment/services/moviesServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class HomePageDataController extends StateNotifier<HomePageModel> {
  HomePageDataController([HomePageModel? state])
      : super(state ?? HomePageModel.initial()) {
    getMovies();
  }

  final MoviesServices moviesServices = GetIt.instance.get<MoviesServices>();

  Future<void> getMovies() async {
    try {
      List<MoviesList>? movies = [];
      movies = await (moviesServices.getPopularMovies(page: state.page));
      state = state.copyWith(
        movies: [...state.movies!, ...movies!],
        page: state.page! + 1,
      );
    } catch (e) {
      log('$e');
      // throw Exception(e);
    }
  }
}
