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
  // Future<List<MoviesList>?> parseMoviesList(Response? response) async{
  //   if (response != null && response.statusCode == 200) {
  //     Map<String, dynamic> data = response.data;
  //     List<dynamic> results = data['results'];
  //     List<MoviesList>? movies = results
  //         .map<MoviesList>((movieData) => MoviesList.fromJson(movieData))
  //         .toList();
  //     return movies;
  //   } else {
  //     throw Exception('Error while parsing movies list.');
  //   }
  // }

  Future<List<MoviesList>?> getPopularMovies({int? page}) async {
    Response? response = await http.get('/movie/popular', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<dynamic> results = data['results'];
      List<MoviesList>? movies = results
          .map<MoviesList>((movieData) => MoviesList.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Could\'t load latest movies. ');
    }
  }

  Future<List<MoviesList>?> getUpcomingMovies({int? page}) async {
    Response? response = await http.get('/movie/upcoming', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<dynamic> results = data['results'];
      List<MoviesList>? movies = results
          .map<MoviesList>((movieData) => MoviesList.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load upcoming movies.');
    }
  }

  Future<List<MoviesList>?> searchMovies(String? searchTerm, {int? page}) async {
    Response? response = await http.get('/search/movie', query: {
      'query': searchTerm,
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<dynamic> results = data['results'];
      List<MoviesList>? movies = results
          .map<MoviesList>((movieData) => MoviesList.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Couldn\'t perform movies search.');
    }
  }
}
