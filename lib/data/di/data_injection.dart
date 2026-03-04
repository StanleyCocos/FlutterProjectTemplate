import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../repositories/auth_repository_impl.dart';
import '../network/di/network_injection.dart';

import '../../core/domain/repositories/auth_repository.dart';
import '../../core/domain/datasources/http_client.dart';

/// 数据层依赖注册（具体实现可接入 get_it / provider 等）
class DataInjection {
  DataInjection._();

  static AuthRepository provideAuthRepository(
    AuthRemoteDataSource remote,
    AuthLocalDataSource local,
  ) {
    return AuthRepositoryImpl(remote, local);
  }

  /// 创建 HTTP 客户端实例
  static HttpClient createHttpClient({
    String? baseUrl,
    bool? enableLogging,
    Future<String?> Function()? tokenProvider,
  }) {
    return NetworkInjection.createHttpClient(
      config: NetworkInjection.createNetworkConfig(
        baseUrl: baseUrl,
        enableLogging: enableLogging,
      ),
      tokenProvider: tokenProvider,
    );
  }
}
