/// 网络配置抽象接口
abstract class NetworkConfig {
  /// 获取基础 URL
  String get baseUrl;

  /// 获取连接超时时间
  Duration get connectTimeout;

  /// 获取接收超时时间
  Duration get receiveTimeout;

  /// 获取发送超时时间
  Duration get sendTimeout;

  /// 是否启用日志
  bool get enableLogging;

  /// 是否启用重试
  bool get enableRetry;

  /// 最大重试次数
  int get maxRetryCount;
}
