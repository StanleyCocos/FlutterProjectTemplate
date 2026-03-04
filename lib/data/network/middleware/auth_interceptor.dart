import '../../../core/domain/datasources/network_interceptor.dart';

/// 认证拦截器 - 自动添加 Token
class AuthInterceptor implements NetworkInterceptor {
  AuthInterceptor(this._tokenProvider);

  final Future<String?> Function() _tokenProvider;
  String? _cachedToken;

  /// 缓存 Token
  Future<void> updateToken() async {
    _cachedToken = await _tokenProvider();
  }

  @override
  void onRequest(
    String path,
    String method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  ) {
    if (_cachedToken != null && headers != null) {
      headers['Authorization'] = 'Bearer $_cachedToken';
    }
  }

  @override
  void onResponse(String path, int statusCode, dynamic data) {
    // 不需要处理
  }

  @override
  void onError(String path, NetworkException error) {
    // 处理 401 未授权错误，刷新 token 等
    if (error.statusCode == 401) {
      // 清除本地 token，跳转登录页等
      _cachedToken = null;
    }
  }
}
