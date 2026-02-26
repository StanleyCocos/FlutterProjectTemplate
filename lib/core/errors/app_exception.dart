/// 应用统一异常
class AppException implements Exception {
  AppException(this.message, {this.code, this.original});

  final String message;
  final String? code;
  final dynamic original;

  @override
  String toString() => 'AppException: $message${code != null ? ' (code: $code)' : ''}';
}
