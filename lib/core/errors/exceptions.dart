/// 应用异常基类
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppException(this.message, {this.code, this.originalException});

  @override
  String toString() => 'AppException: $message';
}

/// 网络异常
class NetworkException extends AppException {
  NetworkException(super.message, {super.code, super.originalException});
}

/// 认证异常
class AuthException extends AppException {
  AuthException(super.message, {super.code, super.originalException});
}

/// 验证异常
class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.originalException});
}
