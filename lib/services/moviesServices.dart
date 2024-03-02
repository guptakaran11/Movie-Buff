import 'package:dio/dio.dart';
import 'package:entertainment/models/moviesList.dart';
import 'package:entertainment/services/httpServices.dart';
import 'package:get_it/get_it.dart';

class MoviesServices {
  final GetIt getIt = GetIt.instance;

  late HTTPService http;

  MoviesServices() {
    http = getIt.get<HTTPService>();
  }

  Future<List<MoviesList>?> getPopularMovies({int? page}) async {
    Response? response = await http.get('/movie/popular', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<MoviesList>? movies = data['results'].map<MoviesList>((movieData) {
        return MoviesList.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Could\'t load latest movies. ');
    }
  }
}
