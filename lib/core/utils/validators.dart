/// 通用校验器
class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) return '请输入邮箱';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return '邮箱格式不正确';
    return null;
  }

  static String? required(String? value, [String fieldName = '此项']) {
    if (value == null || value.trim().isEmpty) return '请输入$fieldName';
    return null;
  }
}
