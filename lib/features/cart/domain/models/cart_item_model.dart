/// 购物车商品数据模型
/// 职责：纯数据结构，不包含业务逻辑
class CartItemModel {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;
}
