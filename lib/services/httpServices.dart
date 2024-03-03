import 'dart:convert';
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
    AppConfigModel config = getIt.get<AppConfigModel>();
    baseUrl = config.BASE_API_URL;
    apiKey = config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
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
      // Response response = await dio.get(url, queryParameters: query);
      return await dio.get(url, queryParameters: query);
      // log('Response Status Code : ${response.statusCode}');
      // log('response data : ${response.data}');
      // return response;
    } on DioException catch (e) {
      log('Unable to perform get request.');
      log('DioError: $e');
      // if (e.response != null) {
      //   log('Response data: ${e.response!.data}');
      // }
      throw Exception(e);
    }
  }
}
