/// 网络拦截器抽象接口
/// 用于在请求发送前后和响应接收前后进行处理
abstract class NetworkInterceptor {
  /// 请求前拦截
  void onRequest(
    String path,
    String method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  );

  /// 响应后拦截
  void onResponse(
    String path,
    int statusCode,
    dynamic data,
  );

  /// 错误拦截
  void onError(
    String path,
    NetworkException error,
  );
}

/// 网络异常定义
class NetworkException implements Exception {
  NetworkException({
    required this.message,
    this.code,
    this.statusCode,
    this.original,
  });

  final String message;
  final String? code;
  final int? statusCode;
  final dynamic original;

  @override
  String toString() {
    return 'NetworkException: $message${code != null ? ' (code: $code)' : ''}';
  }
}
