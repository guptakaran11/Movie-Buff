import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:entertainment/models/appConfigModel.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String? baseUrl;
  String? apiKey;

  HTTPService() {
    AppConfigModel configModel = getIt.get<AppConfigModel>();
    baseUrl = configModel.BASE_API_URL;
    apiKey = configModel.API_KEY;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$baseUrl$path';
      log(url);
      Map<String, dynamic> queryPath = {
        'apiKey': apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        queryPath.addAll(query);
      }
      return await dio.get(url, queryParameters: queryPath);
    } catch (e) {
      log('Unable to perform get request.');
      log('DioError is: $e');
      throw Exception(e);
    }
  }
}
