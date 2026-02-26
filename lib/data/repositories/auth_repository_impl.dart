import '../../core/domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

/// AuthRepository 实现，编排 remote/local 数据源
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._remote,
    this._local,
  );

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<void> login(String email, String password) async {
    final res = await _remote.login(email, password);
    final token = res['token'] as String?;
    if (token != null) await _local.saveToken(token);
  }

  @override
  Future<void> register(String email, String password, String? name) async {
    final res = await _remote.register(email, password, name);
    final token = res['token'] as String?;
    if (token != null) await _local.saveToken(token);
  }

  @override
  Future<void> logout() async {
    await _local.clearToken();
  }

  @override
  Future<bool> get isLoggedIn async {
    final token = await _local.getToken();
    return token != null && token.isNotEmpty;
  }
}
