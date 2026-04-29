import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/login_page.dart';
import '../../features/auth/presentation/view/register_page.dart';
import '../../features/detail/presentation/view/detail_page.dart';
import '../../features/home/presentation/view/home_page.dart';
import '../../features/list/presentation/view/list_page.dart';
import '../../features/photo_picker/presentation/view/photo_picker_page.dart';
import '../../features/splash/presentation/view/splash_page.dart';
import 'route_names.dart';

/// 应用路由配置（使用 GoRouter 作为底层实现）
///
/// GoRouter 提供声明式路由、深度链接、路由守卫等功能。
/// 本类封装 GoRouter 配置，未来如需更换路由库，只需修改本类。
class AppRouter {
  AppRouter._();

  /// 创建简单的 GoRoute（path 和 name 相同）
  static GoRoute _goRoute(String name, Widget child) {
    return GoRoute(
      path: name,
      name: name,
      pageBuilder: (context, _) => MaterialPage(child: child),
    );
  }

  /// GoRouter 实例，供导航中间层使用
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      _goRoute(RouteNames.splash, const SplashPage()),
      _goRoute(RouteNames.login, const LoginPage()),
      _goRoute(RouteNames.register, const RegisterPage()),
      _goRoute(RouteNames.home, HomePage()),
      _goRoute(RouteNames.list, const ListPage()),
      _goRoute(RouteNames.detail, const DetailPage()),
      _goRoute(RouteNames.photoPicker, const PhotoPickerPage()),
    ],
  );
}
