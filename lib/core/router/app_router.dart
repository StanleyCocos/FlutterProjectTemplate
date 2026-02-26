import 'package:flutter/material.dart';

import '../../features/auth/presentation/view/login_page.dart';
import '../../features/auth/presentation/view/register_page.dart';
import '../../features/home/presentation/view/home_page.dart';
import '../../features/splash/presentation/view/splash_page.dart';
import 'route_names.dart';

/// 应用路由配置（可后续替换为 GoRouter）
class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SplashPage(),
        );
      case RouteNames.login:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const LoginPage(),
        );
      case RouteNames.register:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const RegisterPage(),
        );
      case RouteNames.home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      default:
        return null;
    }
  }
}
