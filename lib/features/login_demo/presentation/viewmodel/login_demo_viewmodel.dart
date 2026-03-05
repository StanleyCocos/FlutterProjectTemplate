import 'package:flutter/foundation.dart';

import '../../../../core/domain/repositories/auth_repository.dart';
import '../../../../core/errors/app_exception.dart';
import '../../models/user_model.dart';

/// 登录页面 ViewModel
/// 职责：
/// - 表单验证（验证规则、错误管理）
/// - 状态管理（loading, error, 用户数据）
/// - 业务逻辑（判断是否可登录）
/// - 调用 Repository 进行数据操作
/// ✅ 包含：状态管理、业务逻辑、数据获取
/// ❌ 不包含：UI 导航、Dialog 显示、Context 操作
class LoginDemoViewModel extends ChangeNotifier {
  LoginDemoViewModel(this._authRepository);

  final AuthRepository _authRepository;
  String _email = '';
  String _password = '';
  bool _loading = false;
  String? _error;
  UserModel? _user;
  bool _obscurePassword = true;

  // Getters
  String get email => _email;
  String get password => _password;
  bool get loading => _loading;
  String? get error => _error;
  UserModel? get user => _user;
  bool get obscurePassword => _obscurePassword;
  bool get canSubmit => _email.isNotEmpty && _password.isNotEmpty;

  /// 更新邮箱
  void updateEmail(String email) {
    _email = email.trim();
    _validateEmail();
    notifyListeners();
  }

  /// 更新密码
  void updatePassword(String password) {
    _password = password;
    _validatePassword();
    notifyListeners();
  }

  /// 切换密码显示/隐藏
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// 执行登录
  /// 这里的所有业务逻辑都属于 ViewModel 职责
  Future<void> login() async {
    if (!canSubmit) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authRepository.login(_email, _password);
      _user = UserModel(
        id: result.userId,
        email: _email,
        name: result.userName,
        avatar: result.avatar,
      );
      // 登录成功，可以通过事件通知 View（但不直接导航）
    } on AppException catch (e) {
      _error = e.message;
    }

    _loading = false;
    notifyListeners();
  }

  /// 邮箱验证逻辑
  bool _validateEmail() {
    if (_email.isEmpty) return true;
    if (!_email.contains('@')) {
      _error = '邮箱格式不正确';
    } else {
      if (_error?.contains('邮箱') ?? false) _error = null;
    }
    return true;
  }

  /// 密码验证逻辑
  bool _validatePassword() {
    if (_password.isEmpty) return true;
    if (_password.length < 6) {
      _error = '密码至少6位';
    } else {
      if (_error?.contains('密码') ?? false) _error = null;
    }
    return true;
  }

  /// 清空表单
  void clearForm() {
    _email = '';
    _password = '';
    _error = null;
    _user = null;
    notifyListeners();
  }
}
