import 'auth_local_datasource.dart';

/// 认证本地数据源实现（模板用内存存储，可替换为 SharedPreferences / 安全存储）
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  String? _token;

  @override
  Future<void> saveToken(String token) async {
    _token = token;
  }

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> clearToken() async {
    _token = null;
  }
}
