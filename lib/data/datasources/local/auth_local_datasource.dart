/// 认证相关本地数据源（Token、用户信息缓存等）
abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}
