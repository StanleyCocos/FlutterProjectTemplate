/// 用户模型
/// 职责：纯数据结构
class UserModel {
  final String id;
  final String email;
  final String name;
  final String? avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });
}
