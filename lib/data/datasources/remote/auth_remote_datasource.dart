/// 认证相关远程数据源（调用登录/注册等 API）
abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(String email, String password, String? name);
}
