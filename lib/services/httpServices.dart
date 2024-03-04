// ignore_for_file: file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:entertainment/models/appConfigModel.dart';

class HTTPService {
  late Dio dio;
  final GetIt getIt = GetIt.instance;

  String? baseUrl;
  String? apikey;

  HTTPService() {
    dio = Dio();
    AppConfigModel config = getIt.get<AppConfigModel>();
    baseUrl = config.BASE_API_URL;
    apikey = config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$baseUrl$path';
      log(url);
      Map<String, dynamic> queryPath = {
        "api_key": apikey,
        "language": 'en-US',
      };

      if (query != null) {
        queryPath.addAll(query);
      }

      Response? response = await dio.get(url, queryParameters: queryPath);

      return response;
    } on DioException catch (e) {
      log('Unable to perform get request.');
      log('DioError: $e');
    }
    return null;
  }
}
