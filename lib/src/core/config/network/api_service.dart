import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fudo_flutter/src/core/config/network/api_exception.dart';
import 'package:fudo_flutter/src/core/config/network/api_response.dart';

abstract class ApiService {
  Future<(ApiException?, ApiResponse<T>)> get<T>(String path);

  Future<(ApiException?, ApiResponse<T>)> post<T>(String path,
      {Map<String, dynamic>? data});
}

class ApiServiceImpl implements ApiService {
  final Connectivity connectivity = Connectivity();
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 6),
    ),
  );

  @override
  Future<(ApiException?, ApiResponse<T>)> post<T>(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = _handleException<T>(() => dio.post<T>(path, data: data));

      return response;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<(ApiException?, ApiResponse<T>)> get<T>(String path) async {
    try {
      final response = _handleException<T>(() => dio.get<T>(path));

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<(ApiException?, ApiResponse<T>)> _handleException<T>(
    Future<Response<dynamic>> Function() handler,
  ) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return (NoConnectionException(), ApiResponse<T>.empty());
    }
    try {
      final res = await handler();
      return (
        null,
        ApiResponse<T>(
          statusCode: res.statusCode ?? 200,
          data: res.data,
        )
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return (TimeOutException(), ApiResponse<T>.empty());
      }
      late final ApiException exception = ApiException(
        message: e.response?.data,
        code: (e.response?.statusCode ?? 1).toString(),
        identifier: 'DioException ${e.message}',
      );
      return (exception, ApiResponse<T>.empty());
    }
  }
}
