import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: MaterialApp(
        title: 'Flutter Project Template',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/splash',
      ),
    );
  }

  AuthRepository _createAuthRepository() {
    final remote = AuthRemoteDataSourceImpl();
    final local = AuthLocalDataSourceImpl();
    return DataInjection.provideAuthRepository(remote, local);
  }
}
