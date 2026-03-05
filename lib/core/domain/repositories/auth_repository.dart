/// 认证 Repository 抽象（由 data 层实现）
abstract class AuthRepository {
  /// 登录
  Future<AuthResult> login(String email, String password);

  /// 注册
  Future<AuthResult> register(String email, String password, String? name);

  /// 登出
  Future<void> logout();

  /// 检查是否已登录
  Future<bool> get isLoggedIn;
}

/// 认证结果
class AuthResult {
  final String userId;
  final String userName;
  final String? avatar;

  AuthResult({
    required this.userId,
    required this.userName,
    this.avatar,
  });
}
