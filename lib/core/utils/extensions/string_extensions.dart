/// String 扩展
extension StringExtensions on String {
  /// 是否为空或仅空白
  bool get isBlank => trim().isEmpty;
}
