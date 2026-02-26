import 'package:flutter/foundation.dart';

import '../../../../core/domain/repositories/auth_repository.dart';
import '../../../../core/router/route_names.dart';

/// 启动页 ViewModel：根据登录态决定跳转登录或首页
class SplashViewModel extends ChangeNotifier {
  SplashViewModel(this._authRepository);

  final AuthRepository _authRepository;

  String _nextRoute = RouteNames.login;
  String get nextRoute => _nextRoute;

  bool _ready = false;
  bool get ready => _ready;

  Future<void> init() async {
    final loggedIn = await _authRepository.isLoggedIn;
    _nextRoute = loggedIn ? RouteNames.home : RouteNames.login;
    _ready = true;
    notifyListeners();
  }
}
