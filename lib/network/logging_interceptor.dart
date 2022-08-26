import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor {
  final int _maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint("<-- Start HTTP");
    return super.onRequest(options, handler);
    // return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
      (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      debugPrint('Response:--   ${response.data}');
    }
    debugPrint("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint("<-- Error -->");
    debugPrint(err.error);
    debugPrint(err.message);
    return super.onError(err, handler);
  }
}