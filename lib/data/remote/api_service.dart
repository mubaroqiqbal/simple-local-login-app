import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:majootestcase/models/home/movie_response.dart';
import 'package:majootestcase/utils/app_strings.dart';

class ApiServices {
  var dio;

  ApiServices(this.dio);

  Future<MovieResponse?> getMovieList(String query) async {
    try {
      Map<String, dynamic> queryParams = {'q': query.isNotEmpty ? query : "game"};
      print(json.encode(queryParams));
      final Response response = await dio.get(
        "title/auto-complete",
        queryParameters: queryParams,
      );

      if (response.data.isNotEmpty) {
        MovieResponse movieResponse = MovieResponse.fromJson(response.data);
        return movieResponse;
      } else {
        return null;
      }
    } on SocketException {
      throw Exception(AppStrings.connection_error);
    }
  }
}
