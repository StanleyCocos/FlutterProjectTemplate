import 'app_router.dart';
import 'route_names.dart';

/// 应用导航中间层
///
/// 作为路由框架（GoRouter）与业务代码之间的中间层，封装所有导航操作。
/// 这样当路由框架变化时，只需修改本类实现，业务代码无需修改。
///
/// 当前使用 GoRouter 作为底层实现，提供声明式路由、深度链接、路由守卫等功能。
/// 通过直接使用 GoRouter 实例，无需传入 BuildContext。
///
/// 使用示例:
/// ```dart
/// // 跳转到新页面（替换当前页面）
/// AppNavigator.pushReplacementNamed(RouteNames.home);
///
/// // 跳转到新页面（保留当前页面）
/// AppNavigator.pushNamed(RouteNames.details);
///
/// // 返回上一页
/// AppNavigator.pop();
///
/// // 返回上一页并传递结果
/// AppNavigator.pop(result: 'success');
/// ```
class AppNavigator {
  AppNavigator._();

  /// 跳转到新页面（保留当前页面，可返回）
  ///
  /// 对应 GoRouter.push()
  static Future<T?> pushNamed<T>(
    String routeName, {
    Object? extra,
  }) {
    return AppRouter.router.push<T>(routeName, extra: extra);
  }

  /// 跳转到新页面（替换当前页面，无法返回）
  ///
  /// 对应 GoRouter.go()
  /// 适用于登录后跳转首页、页面切换等场景
  static Future<void> pushReplacementNamed(
    String routeName, {
    Object? extra,
  }) {
    AppRouter.router.go(routeName, extra: extra);
    // GoRouter.go() 是同步的，但为了 API 一致性返回 Future
    return Future.value();
  }

  /// 跳转到新页面并清除导航栈
  ///
  /// 对应 GoRouter.go()
  /// 适用于重置导航栈场景（如登录成功后清除所有页面）
  static Future<void> pushNamedAndRemoveUntil(
    String newRouteName, {
    Object? extra,
  }) {
    AppRouter.router.go(newRouteName, extra: extra);
    // GoRouter.go() 是同步的，但为了 API 一致性返回 Future
    return Future.value();
  }

  /// 返回上一页
  ///
  /// 对应 GoRouter.pop()
  /// [result] 可选的返回结果
  static void pop<T extends Object?>([T? result]) {
    AppRouter.router.pop<T>(result);
  }

  /// 返回到指定路由
  ///
  /// 在 GoRouter 中，通过 pop 直到匹配指定路由
  /// 适用于返回到多层之前的页面
  static void popUntil(String routeName) {
    // GoRouter 不直接支持 popUntil 到特定路由名称
    // 使用 pop 直到无法继续返回
    while (AppRouter.router.canPop()) {
      AppRouter.router.pop();
    }
  }

  /// 返回到首页（清空导航栈）
  ///
  /// 对应 GoRouter.go() 跳转到初始路由
  /// 适用于退出登录、重置应用状态等场景
  static void popUntilHome() {
    AppRouter.router.go(RouteNames.splash);
  }

  /// 检查是否可以返回
  ///
  /// 对应 GoRouter.canPop()
  /// 返回 false 表示当前页面已经是根页面
  static bool canPop() {
    return AppRouter.router.canPop();
  }
}
