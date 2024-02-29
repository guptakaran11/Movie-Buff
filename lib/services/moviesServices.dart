import 'package:entertainment/services/httpServices.dart';
import 'package:get_it/get_it.dart';

class MoviesServices {
  final GetIt getIt = GetIt.instance;

  HTTPService? http;

  MoviesServices() {
    http = getIt.get<HTTPService>();
  }
}
