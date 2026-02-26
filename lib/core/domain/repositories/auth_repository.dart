/// 认证 Repository 抽象（由 data 层实现）
abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(String email, String password, String? name);
  Future<void> logout();
  Future<bool> get isLoggedIn;
}
