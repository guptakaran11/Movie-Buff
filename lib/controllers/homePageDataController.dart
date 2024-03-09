// ignore_for_file: file_names
import 'dart:developer';
import 'package:entertainment/models/homePageModel.dart';
import 'package:entertainment/models/moviesList.dart';
import 'package:entertainment/models/searchCategory.dart';
import 'package:entertainment/services/moviesServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class HomePageDataController extends StateNotifier<HomePageModel> {
  HomePageDataController([HomePageModel? state])
      : super(state ?? HomePageModel.initial()) {
    getMovies();
  }

  final MoviesServices moviesService = GetIt.instance.get<MoviesServices>();

  Future<void> getMovies() async {
    try {
      List<MoviesList>? movies = [];

      if (state.searchText!.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await moviesService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await moviesService.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          movies = [];
        }
      } else {
        log('Searching movies for query: ${state.searchText}');
        movies = await (moviesService.searchMovies(state.searchText));
      }
      // log('Received movies: $movies');
      state = state.copyWith(
        movies: [...state.movies!, ...movies!],
        page: state.page! + 1,
      );
      log('state is $state');
    } catch (e) {
      log('Error is: $e');
      // throw Exception(e);
    }
  }

  void updateSearchCategory(String? category) {
    try {
      state = state.copyWith(
        movies: [],
        page: 1,
        searchCategory: category,
        searchText: '',
      );
      getMovies();
    } catch (e) {
      log('$e');
    }
  }

  void updateTextSearch(String searchText) {
    try {
      state = state.copyWith(
        movies: [],
        page: 1,
        searchCategory: SearchCategory.none,
        searchText: searchText,
      );
      getMovies();
    } catch (e) {
      log('$e');
    }
  }
}
