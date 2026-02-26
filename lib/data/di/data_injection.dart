import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../repositories/auth_repository_impl.dart';

import '../../core/domain/repositories/auth_repository.dart';

/// 数据层依赖注册（具体实现可接入 get_it / provider 等）
class DataInjection {
  DataInjection._();

  static AuthRepository provideAuthRepository(
    AuthRemoteDataSource remote,
    AuthLocalDataSource local,
  ) {
    return AuthRepositoryImpl(remote, local);
  }
}
