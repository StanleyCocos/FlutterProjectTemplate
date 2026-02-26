import 'auth_remote_datasource.dart';

/// 认证远程数据源实现（模板用桩实现）
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return {'token': 'stub_token_$email'};
  }

  @override
  Future<Map<String, dynamic>> register(String email, String password, String? name) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return {'token': 'stub_token_$email'};
  }
}
