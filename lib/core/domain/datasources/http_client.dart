/// HTTP 客户端抽象接口
/// 定义网络请求的核心契约，可由 Dio、http、HttpClient 等实现
abstract class HttpClient {
  /// GET 请求
  Future<NetworkResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// POST 请求
  Future<NetworkResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// PUT 请求
  Future<NetworkResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// DELETE 请求
  Future<NetworkResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// 设置基础 URL
  void setBaseUrl(String baseUrl);

  /// 添加请求头
  void addHeader(String key, String value);

  /// 移除请求头
  void removeHeader(String key);

  /// 取消所有请求
  void cancelAllRequests();

  /// 关闭客户端
  void close();
}

/// 网络响应封装
class NetworkResponse<T> {
  NetworkResponse({
    required this.data,
    required this.statusCode,
    this.headers,
    this.message,
  });

  final T data;
  final int statusCode;
  final Map<String, String>? headers;
  final String? message;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
  bool get isServerError => statusCode >= 500;
  bool get isClientError => statusCode >= 400 && statusCode < 500;
}
