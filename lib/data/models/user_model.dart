/// 用户 DTO / 数据模型（与 API 结构对应）
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    this.name,
  });

  final String id;
  final String email;
  final String? name;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
      };
}
