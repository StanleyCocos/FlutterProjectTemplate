/// 登录用户数据模型
/// 职责：纯数据结构，不包含业务逻辑
class LoginUserModel {
  final String id;
  final String email;
  final String name;
  final String? avatar;

  LoginUserModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      if (avatar != null) 'avatar': avatar,
    };
  }
}
