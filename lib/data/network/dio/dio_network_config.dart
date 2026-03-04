import '../../../core/domain/datasources/network_config.dart';

/// Dio 网络配置实现
class DioNetworkConfig implements NetworkConfig {
  DioNetworkConfig({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool? enableLogging,
    bool? enableRetry,
    int? maxRetryCount,
  })  : _baseUrl = baseUrl ?? 'https://api.example.com',
        _connectTimeout = connectTimeout ?? const Duration(seconds: 30),
        _receiveTimeout = receiveTimeout ?? const Duration(seconds: 30),
        _sendTimeout = sendTimeout ?? const Duration(seconds: 30),
        _enableLogging = enableLogging ?? true,
        _enableRetry = enableRetry ?? true,
        _maxRetryCount = maxRetryCount ?? 3;

  final String _baseUrl;
  final Duration _connectTimeout;
  final Duration _receiveTimeout;
  final Duration _sendTimeout;
  final bool _enableLogging;
  final bool _enableRetry;
  final int _maxRetryCount;

  @override
  String get baseUrl => _baseUrl;

  @override
  Duration get connectTimeout => _connectTimeout;

  @override
  Duration get receiveTimeout => _receiveTimeout;

  @override
  Duration get sendTimeout => _sendTimeout;

  @override
  bool get enableLogging => _enableLogging;

  @override
  bool get enableRetry => _enableRetry;

  @override
  int get maxRetryCount => _maxRetryCount;
}
