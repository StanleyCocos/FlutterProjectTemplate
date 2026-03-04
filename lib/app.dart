import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/api_constants.dart';
import 'core/domain/repositories/auth_repository.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/auth_local_datasource_impl.dart';
import 'data/datasources/remote/auth_remote_datasource_impl.dart';
import 'data/di/data_injection.dart';
import 'features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'features/auth/presentation/viewmodel/register_viewmodel.dart';
import 'features/home/presentation/viewmodel/home_viewmodel.dart';
import 'features/splash/presentation/viewmodel/splash_viewmodel.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = _createAuthRepository();
    return MultiProvider(
      providers: [
        Provider<AuthRepository>.value(value: authRepo),
        ChangeNotifierProvider<SplashViewModel>(
          create: (_) => SplashViewModel(authRepo),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(authRepo),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (_) => RegisterViewModel(authRepo),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Project Template',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }

  AuthRepository _createAuthRepository() {
    // 创建 HTTP 客户端（使用网络中间层）
    final httpClient = DataInjection.createHttpClient(
      baseUrl: ApiConstants.baseUrl,
      enableLogging: true, // 调试模式启用日志
      tokenProvider: _getToken,
    );

    final remote = AuthRemoteDataSourceImpl(httpClient);
    final local = AuthLocalDataSourceImpl();
    return DataInjection.provideAuthRepository(remote, local);
  }

  /// 获取认证 Token
  Future<String?> _getToken() async {
    // 从本地存储获取 token
    // 实际实现中可以从 LocalDataSource 或 SharedPreferences 获取
    return null;
  }
}
