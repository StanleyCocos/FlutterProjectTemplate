import '../../../core/domain/datasources/network_interceptor.dart';

/// 错误拦截器 - 统一错误处理
class ErrorInterceptor implements NetworkInterceptor {
  @override
  void onRequest(
    String path,
    String method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  ) {
    // 不需要处理
  }

  @override
  void onResponse(String path, int statusCode, dynamic data) {
    // 可以在这里处理业务层面的错误码
    if (data is Map<String, dynamic> && data.containsKey('code')) {
      final code = data['code'];
      if (code != 0) {
        // 业务错误处理
        // 可以在这里记录日志或触发错误上报
      }
    }
  }

  @override
  void onError(String path, NetworkException error) {
    // 统一错误处理，如显示 toast、记录日志等
    // 这里只做记录，实际 UI 反馈由业务层处理
  }
}
