import 'package:flutter/foundation.dart';

import '../../../core/domain/datasources/network_interceptor.dart';

/// 日志拦截器
class LoggingInterceptor implements NetworkInterceptor {
  LoggingInterceptor({bool enabled = true}) : _enabled = enabled;

  final bool _enabled;

  void _log(String message, {dynamic error}) {
    if (!_enabled) return;
    debugPrint('[Network] $message');
    if (error != null) {
      debugPrint('[Network] Error: $error');
    }
  }

  @override
  void onRequest(
    String path,
    String method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  ) {
    if (!_enabled) return;
    _log('Request: $method $path');
    _log('Headers: $headers');
    _log('Data: $data');
  }

  @override
  void onResponse(String path, int statusCode, dynamic data) {
    if (!_enabled) return;
    _log('Response: $path - $statusCode');
    _log('Data: $data');
  }

  @override
  void onError(String path, NetworkException error) {
    if (!_enabled) return;
    _log('Error: $path - ${error.message}', error: error.original);
  }
}
