/// 认证 Feature 内使用的用户模型（UI 层）
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
  });

  final String id;
  final String email;
  final String? displayName;
}
