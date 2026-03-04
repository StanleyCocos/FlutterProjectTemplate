import 'package:dio/dio.dart';

import '../../../core/domain/datasources/http_client.dart';
import '../../../core/domain/datasources/network_interceptor.dart';

/// Dio 实现的 HTTP 客户端
class DioHttpClient implements HttpClient {
  DioHttpClient({
    required Dio dio,
    required List<NetworkInterceptor> interceptors,
  })  : _dio = dio,
        _interceptors = interceptors {
    _setupInterceptors();
  }

  final Dio _dio;
  final List<NetworkInterceptor> _interceptors;

  void _setupInterceptors() {
    // 添加请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          for (final interceptor in _interceptors) {
            interceptor.onRequest(
              options.path,
              options.method,
              options.data,
              options.headers as Map<String, String>?,
            );
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          for (final interceptor in _interceptors) {
            interceptor.onResponse(
              response.requestOptions.path,
              response.statusCode ?? 0,
              response.data,
            );
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          final networkException = _parseDioError(error);
          for (final interceptor in _interceptors) {
            interceptor.onError(
              error.requestOptions.path,
              networkException,
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  NetworkException _parseDioError(DioException error) {
    String message = 'Network error occurred';
    String? code;
    int? statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        code = 'CONNECTION_TIMEOUT';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        code = 'SEND_TIMEOUT';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        code = 'RECEIVE_TIMEOUT';
        break;
      case DioExceptionType.badResponse:
        message = 'Bad response';
        code = 'BAD_RESPONSE';
        statusCode = error.response?.statusCode;
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        code = 'CANCELLED';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error';
        code = 'CONNECTION_ERROR';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        code = 'BAD_CERTIFICATE';
        break;
      case DioExceptionType.unknown:
        message = error.message ?? 'Unknown error';
        code = 'UNKNOWN';
        break;
    }

    return NetworkException(
      message: message,
      code: code,
      statusCode: statusCode,
      original: error,
    );
  }

  NetworkResponse<T> _parseResponse<T>(Response response) {
    return NetworkResponse<T>(
      data: response.data as T,
      statusCode: response.statusCode ?? 0,
      headers: response.headers.map.map(
        (key, value) => MapEntry(key, value.join(',')),
      ),
    );
  }

  @override
  Future<NetworkResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse<T>(response);
    } on DioException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'GET request failed: ${e.toString()}',
        original: e,
      );
    }
  }

  @override
  Future<NetworkResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse<T>(response);
    } on DioException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'POST request failed: ${e.toString()}',
        original: e,
      );
    }
  }

  @override
  Future<NetworkResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse<T>(response);
    } on DioException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'PUT request failed: ${e.toString()}',
        original: e,
      );
    }
  }

  @override
  Future<NetworkResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _parseResponse<T>(response);
    } on DioException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'DELETE request failed: ${e.toString()}',
        original: e,
      );
    }
  }

  @override
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  @override
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  @override
  void cancelAllRequests() {
    _dio.close(force: true);
  }

  @override
  void close() {
    _dio.close();
  }
}
