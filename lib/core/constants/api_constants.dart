/// API 路径与接口常量
class ApiConstants {
  ApiConstants._();

  /// 基础 URL（可按环境切换）
  static const String baseUrl = 'https://api.example.com';

  /// API 版本前缀
  static const String apiVersion = '/v1';

  // 示例接口路径
  static const String login = '$apiVersion/auth/login';
  static const String register = '$apiVersion/auth/register';
  static const String userProfile = '$apiVersion/user/profile';
}
