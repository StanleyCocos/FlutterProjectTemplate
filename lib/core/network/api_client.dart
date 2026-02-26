import '../constants/api_constants.dart';

/// 网络客户端封装（占位，实际可接入 dio/http 等）
class ApiClient {
  ApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? ApiConstants.baseUrl;

  final String _baseUrl;

  String get baseUrl => _baseUrl;

  // 后续可添加 get/post 方法及拦截器
}
