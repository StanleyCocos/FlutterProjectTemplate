import 'package:flutter/foundation.dart';

import '../../../../core/domain/repositories/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel(this._authRepository);

  final AuthRepository _authRepository;

  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  Future<void> register(String email, String password, String? name) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await _authRepository.register(email, password, name);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
