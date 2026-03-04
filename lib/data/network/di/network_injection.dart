import 'package:dio/dio.dart';

import '../../../core/domain/datasources/http_client.dart';
import '../../../core/domain/datasources/network_config.dart';
import '../dio/dio_http_client.dart';
import '../dio/dio_network_config.dart';
import '../middleware/auth_interceptor.dart';
import '../middleware/error_interceptor.dart';
import '../middleware/logging_interceptor.dart';

/// 网络层依赖注入
class NetworkInjection {
  NetworkInjection._();

  /// 创建 Dio 实例
  static Dio createDio(NetworkConfig config) {
    return Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
      ),
    );
  }

  /// 创建网络配置
  static NetworkConfig createNetworkConfig({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool? enableLogging,
    bool? enableRetry,
    int? maxRetryCount,
  }) {
    return DioNetworkConfig(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      enableLogging: enableLogging,
      enableRetry: enableRetry,
      maxRetryCount: maxRetryCount,
    );
  }

  /// 创建拦截器列表
  static List<dynamic> createInterceptors({
    required NetworkConfig config,
    Future<String?> Function()? tokenProvider,
  }) {
    final interceptors = <dynamic>[];

    if (config.enableLogging) {
      interceptors.add(LoggingInterceptor(enabled: true));
    }

    if (tokenProvider != null) {
      final authInterceptor = AuthInterceptor(tokenProvider);
      interceptors.add(authInterceptor);
    }

    interceptors.add(ErrorInterceptor());

    return interceptors;
  }

  /// 创建 HTTP 客户端
  static HttpClient createHttpClient({
    NetworkConfig? config,
    Future<String?> Function()? tokenProvider,
  }) {
    final networkConfig = config ?? createNetworkConfig();
    final dio = createDio(networkConfig);
    final interceptors = createInterceptors(
      config: networkConfig,
      tokenProvider: tokenProvider,
    );

    // 将拦截器转换为 NetworkInterceptor 类型
    final networkInterceptors = interceptors
        .whereType<dynamic>()
        .toList();

    return DioHttpClient(
      dio: dio,
      interceptors: networkInterceptors.cast(),
    );
  }
}
