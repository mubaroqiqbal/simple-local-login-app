import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> dio() async {
  Dio dioInstance = new Dio(
    BaseOptions(
      baseUrl: "https://imdb8.p.rapidapi.com/",
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {
        "x-rapidapi-key": "d234eb5e71msh8521e9cea371c24p18b547jsna73f99e93f27",
        "x-rapidapi-host": "imdb8.p.rapidapi.com",
      },
    ),
  );

  dioInstance.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      responseBody: true,
    ),
  );

  return dioInstance;
}
