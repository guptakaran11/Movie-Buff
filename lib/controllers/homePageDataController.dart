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

  final MoviesServices movieService = GetIt.instance.get<MoviesServices>();

  Future<void> getMovies() async {
    try {
      List<MoviesList> movies = [];
      movies = (await movieService.getPopularMovies(page: state.page))!;
    } catch (e) {
      print(e);
    }
  }
}
