import 'package:flutter/foundation.dart';

import '../../../../core/domain/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._authRepository);

  final AuthRepository _authRepository;

  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await _authRepository.login(email, password);
      _loading = false;
      notifyListeners();
      // 导航由 View 根据结果或全局路由守卫处理，此处仅完成登录
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
