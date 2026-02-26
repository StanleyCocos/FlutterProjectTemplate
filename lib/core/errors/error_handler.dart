import 'app_exception.dart';

/// 统一错误处理/上报
class ErrorHandler {
  ErrorHandler._();

  static void handle(Object error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      // 可在此上报或展示
      return;
    }
    // 未预期异常
  }
}
