
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meditech/core/http/url.dart';

import '../error/failure.dart';


class TDioHelper {
  var r = Either<Failure, Map<String, dynamic>>;
  static late final Dio _dio;
  static init() {
    _dio = Dio(
      BaseOptions(
          baseUrl: Urls.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1)),
    );
  }

  static responseHandler({token, store}) {
    if (token != null) {
      String tokenByBarren = "Bearer " + token;
      if (store != null) {
        _dio.options.headers = {
          'Authorization': tokenByBarren,
          'SP_Name': store
        };
      } else {
        _dio.options.headers = {
          'Authorization': tokenByBarren,
        };
      }
    } else {
      if (store != null) {
        _dio.options.headers = {
          'SP_Name': store,
        };
      }
    }
  }

  // Helper method to make a GET request
  static Future<Either<Failure, Map<String, dynamic>>> get(String endpoint,
      {String? token, String? store}) async {
    try {
      responseHandler(token: token, store: store);
      final response = await _dio.get('${Urls.baseUrl}/$endpoint');
      return _handleResponse(response);
    } catch (error) {
      return Left(ServerFailure('Failed to load data: $error'));
    }
  }

  // Helper method to make a POST request
  static Future<Either<Failure, Map<String, dynamic>>> post(
      String endpoint, dynamic data,
      {String? token, String? store}) async {
    try {
      responseHandler(token: token, store: store);
      final response = await _dio.post('${Urls.baseUrl}/$endpoint', data: data);
      return _handleResponse(response);
    } catch (error) {
      return Left(ServerFailure('Failed to load data: $error'));
    }
  }

  // Helper method to make a PUT request
  static Future<Either<Failure, Map<String, dynamic>>> put(
      String endpoint, dynamic data,
      {String? token, String? store}) async {
    try {
      responseHandler(token: token, store: store);
      final response = await _dio.put('${Urls.baseUrl}/$endpoint', data: data);
      return _handleResponse(response);
    } on DioException catch (error) {
      return Left(ServerFailure('Failed to load data: $error'));
    }
  }

  // Helper method to make a DELETE request
  static Future<Either<Failure, Map<String, dynamic>>> delete(String endpoint,
      {String? token, String? store}) async {
    try {
      responseHandler(token: token, store: store);

      final response = await _dio.delete('${Urls.baseUrl}/$endpoint');
      return _handleResponse(response);
    } catch (error) {
      return Left(ServerFailure('Failed to load data: $error'));
    }
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse1(Response response) {
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Either<Failure, T> _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      final T responseData = response.data;
      return Right(responseData);
    } else {
      final errorMessage =
          'Error occurred with status code: ${response.statusCode}';
      return Left(ServerFailure(errorMessage));
    }
  }
}
