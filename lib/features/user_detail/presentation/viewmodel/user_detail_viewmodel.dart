import 'package:flutter/foundation.dart';

/// 用户详情 ViewModel
/// 职责：
/// - 状态管理（用户数据、编辑状态）
/// - 业务逻辑（保存用户、更新用户）
/// ✅ 包含：状态管理、业务逻辑
/// ❌ 不包含：UI 导航、Toast 显示
class UserDetailViewModel extends ChangeNotifier {
  late UserDetailModel _user;
  bool _editing = false;
  String _editedName = '';
  bool _loading = false;
  String? _error;

  // Getters
  UserDetailModel get user => _user;
  bool get editing => _editing;
  String get editedName => _editedName;
  bool get loading => _loading;
  String? get error => _error;

  /// 更新用户
  /// 业务逻辑：验证数据格式
  void updateUser(UserDetailModel user) {
    _user = user;
    notifyListeners();
  }

  /// 开始编辑模式
  void startEditing() {
    _editing = true;
    _editedName = _user.name;
    notifyListeners();
  }

  /// 更新用户信息
  /// 业务逻辑：验证长度、特殊字符
  Future<void> saveUser() async {
    if (_editedName.trim().isEmpty) {
      _error = '用户名不能为空';
      notifyListeners();
      return;
    }

    if (_editedName.length < 2) {
      _error = '用户名至少2个字符';
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();

    // 模拟保存
    await Future.delayed(const Duration(seconds: 1));

    _user = UserDetailModel(
      id: _user.id,
      email: _user.email,
      name: _editedName.trim(),
      avatar: _user.avatar,
    );

    _loading = false;
    _editing = false;
    _error = null;
    notifyListeners();
  }

  /// 取消编辑
  void cancelEditing() {
    _editing = false;
    _editedName = '';
    _error = null;
    notifyListeners();
  }
}

/// 用户详情数据模型
/// 职责：纯数据结构
class UserDetailModel {
  final String id;
  final String email;
  final String name;
  final String? avatar;

  UserDetailModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });
}
